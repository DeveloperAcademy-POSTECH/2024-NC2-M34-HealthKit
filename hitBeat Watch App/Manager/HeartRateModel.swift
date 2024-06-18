//
//  HeartRateModel.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import Foundation
import SwiftUI
import HealthKit

class HeartRateModel: ObservableObject {
    @Published var heartRate: Double = 0
    
    private let healthStore = HKHealthStore()
    
    init() {
        requestHeartRatePermission()
    }
    
    func requestHeartRatePermission() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { (success, error) in
            if success {
                self.startHeartRateQuery()
            } else {
                print("건강 데이터에 대한 권한을 얻지 못했습니다.")
            }
        }
    }
    
    func startHeartRateQuery() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        
        let query = HKObserverQuery(sampleType: heartRateType, predicate: nil) { (query, completionHandler, error) in
            self.fetchLatestHeartRate()
        }
        
        healthStore.execute(query)
    }
    
    func fetchLatestHeartRate() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard let results = results as? [HKQuantitySample] else { return }
            
            if let sample = results.last {
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = sample.quantity.doubleValue(for: heartRateUnit)
                DispatchQueue.main.async {
                    self.heartRate = Double(value)
                }
            }
        }
        
        healthStore.execute(query)
    }
}

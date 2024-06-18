//
//  HeartRateModel.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import Foundation
import SwiftUI
import HealthKit

//class HeartRateModel: ObservableObject {
//    @Published var heartRate: Double = 0
//    
//    private let healthStore = HKHealthStore()
//    
//    init() {
//        requestHeartRatePermission()
//    }
//    
//    func requestHeartRatePermission() {
//        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
//        
//        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { (success, error) in
//            if success {
//                self.startHeartRateQuery()
//            } else {
//                print("건강 데이터에 대한 권한을 얻지 못했습니다.")
//            }
//        }
//    }
//    
//    func startHeartRateQuery() {
//        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
//        
//        let query = HKObserverQuery(sampleType: heartRateType, predicate: nil) { (query, completionHandler, error) in
//            if error == nil {
//                self.fetchLatestHeartRate()
//                completionHandler()
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    func fetchLatestHeartRate() {
//        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
//        
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
//            guard let results = results as? [HKQuantitySample], let sample = results.first else { return }
//            
//            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
//            let value = sample.quantity.doubleValue(for: heartRateUnit)
//            DispatchQueue.main.async {
//                self.heartRate = value
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//}


class HeartRateModel: ObservableObject {
    @Published var heartRate: Double = 0
    
    private let healthStore = HKHealthStore()
    private var anchor: HKQueryAnchor?
    
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
        
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: anchor, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, newAnchor, error) in
            self.anchor = newAnchor
            self.process(samples: samples)
        }
        
        query.updateHandler = { (query, samples, deletedObjects, newAnchor, error) in
            self.anchor = newAnchor
            self.process(samples: samples)
        }
        
        healthStore.execute(query)
    }
    
    private func process(samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }
        
        if let sample = samples.last {
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let value = sample.quantity.doubleValue(for: heartRateUnit)
            DispatchQueue.main.async {
                self.heartRate = value
            }
        }
    }
}

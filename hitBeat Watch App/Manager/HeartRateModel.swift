//
//  HeartRateManager.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import Foundation
import SwiftUI
import HealthKit

class HeartRateManager: ObservableObject {
    @Published var heartRate: Double = 0
//    test
    @Published var heartRateHistory: [Double] = [89,79,89,90,93,94,95,93,85,79]
//    @Published var heartRateHistory: [Double] = []
    
    private let healthStore = HKHealthStore()
    private var anchor: HKQueryAnchor?
    private var timer: Timer?
    private var heartsum: Double?
    
    init() {
        requestHeartRatePermission()
    }
    
    func requestHeartRatePermission() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { (success, error) in
            if success {
                self.startHeartRateQuery()
//                self.startTimer()
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
//                self.addToHeartRateHistory(value)
                
                print("------------------------------")
                print("\(self.heartRateHistory) 이고 개수\(self.heartRateHistory.count)")
                
            }
        }
    }
    
    private func addToHeartRateHistory(_ value: Double) {
        heartRateHistory.append(value)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.addToHeartRateHistory(self.heartRate)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func heartSum() -> Double{
         heartsum = heartRateHistory.reduce(0, + )
        return heartsum!
    }
    
}

//
//  HeartRateView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

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


struct HeartRateView: View {
    
    @ObservedObject var model = HeartRateModel()
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    
    var body: some View {
        
//        l heart = model.heartRate
        ScrollView{
            VStack {
                
                CustomSlider(value: $model.heartRate, range: Double(minRate)...Double(maxRate))
                    .frame(height: 50)
                    .padding()
                
                Text("심박수: \(Int(round(model.heartRate)))")
                    .font(.title)
                    .padding()
                
                
                VStack {
                    Text("Selected Item: \(item)")
                        .font(.headline)
                        .padding()
                    
                    Text("당신의 최대 심박: \(maxRate)")
                        .font(.headline)
                        .padding()
                    Text("당신의 최소 심박: \(minRate)")
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

// MARK: - CustomSliderView

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            HStack(spacing:0){
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 4)
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width, height: 4)
                    
                        
                    VStack {
                        Circle()
                        Image(systemName: "figure.run")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 10, height: 10)
                            .offset(x: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width
                                    - 10)
                            
                        
                        Text("\(Int(value))")
                            .font(.caption)
                            .offset(x: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width
                                    - 10)
                    }
                    
                    
                }
            }
        }
        .frame(height: 20)
    }
}


struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView(maxRate: 200, minRate: 180, item: "")
    }
}

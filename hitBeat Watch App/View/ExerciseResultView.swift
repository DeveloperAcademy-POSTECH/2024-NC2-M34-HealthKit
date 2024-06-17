//
//  ExerciseResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//
import SwiftUI
import HealthKit

struct ExerciseResultView: View {
    
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


#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "")
}

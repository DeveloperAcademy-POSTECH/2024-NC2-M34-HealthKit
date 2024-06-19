//
//  HeartRateView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI
import HealthKit

struct HeartRateView: View {
    
    @EnvironmentObject var stopwatchManager: StopwatchManager
    @EnvironmentObject var heartRateManager: HeartRateManager
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    var body: some View {
        @State var min = Double(minRate)
        @State var max = Double(maxRate)
        
        VStack(spacing: 0){
            Circle()
                .fill(.gray)
                .frame(height: 50)

                
            HStack(alignment: .bottom){
                Text("\(Int(round(heartRateManager.heartRate)))")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.hitRed)
                
                Text("BPM")
                    .foregroundColor(.hitRed)
            }
//            .padding(2)
                
            if Int(heartRateManager.heartRate) < minRate{
                
                
                Text("잠시만요!")
                    .font(.caption2)
                Text("심박수를 조금 더 올려주세요.")
                    .font(.caption2)
                
                CustomSlider(value: $min, range: Double(minRate)...Double(maxRate),max: maxRate, min: minRate)
            } else{
                if Int(heartRateManager.heartRate) > maxRate {
                    
                    Text("심박수가 기본보다 높아요!")
                        .font(.caption2)
                    Text("심박수를 낮춰주세요.")
                        .font(.caption2)
                    
                    CustomSlider(value: $max, range: Double(minRate)...Double(maxRate),max: maxRate, min: minRate)
                } else{
                    Text("좋아요.")
                        .font(.caption2)
                    Text("지금의 상태를 유지하세요.")
                        .font(.caption2)
                    
                    CustomSlider(value: $heartRateManager.heartRate, range: Double(minRate)...Double(maxRate),max: maxRate, min: minRate)
                }
            }
            
            
            
            
            Spacer(minLength: 40)
        }
        .padding()
    }
}


// MARK: - CustomSliderView

struct CustomSlider: View {
    @Binding var value: Double
    
    let range: ClosedRange<Double>
    let max: Int
    let min: Int
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            VStack(spacing:0){
                HStack(spacing: 0){
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.backgroundRed)
                            .cornerRadius(20)
                            .frame(height: 8)
                        
                        Rectangle()
                            .foregroundColor(.hitRed)
                            .cornerRadius(20)
                            .frame(width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width, height: 8)
                        
                        
                        VStack {
                            Circle()
                            Image(systemName: "figure.run")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 6, height: 6)
                                .offset(x: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width
                                        - 10)
                        }
                        .padding(.bottom,4)
                    }
                }
                HStack{
                    Text("\(min)")
                    Spacer()
                    Text("\(max)")
                }
            }
        }
        .padding()
        
    }
}





#Preview {
    HeartRateView( maxRate: 200, minRate: 180,item: "")
        .environmentObject(StopwatchManager())
        .environmentObject(HeartRateManager())
}

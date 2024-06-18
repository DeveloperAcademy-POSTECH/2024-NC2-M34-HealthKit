//
//  HeartRateView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//
//
//import SwiftUI
//import HealthKit
//
//struct HeartRateView: View {
//    
//    @EnvironmentObject var stopwatchManager: StopwatchManager
//    
//    @ObservedObject var model = HeartRateModel()
//    
//    @Binding var isShowingHeartRateView: Bool
//    
//    var maxRate: Int
//    var minRate: Int
//    var item: String
//    
//    
//    var body: some View {
//        
////        l heart = model.heartRate
//        ScrollView{
//            VStack {
//                
//                CustomSlider(value: $model.heartRate, range: Double(minRate)...Double(maxRate))
//                    .frame(height: 50)
//                    .padding()
//                
//                Text("심박수: \(Int(round(model.heartRate)))")
//                    .font(.title)
//                    .padding()
//                
//                Text(stopwatchManager.formattedTime)
//                    .font(.largeTitle)
//                    .padding()
//                
//                
//                VStack {
//                    Text("Selected Item: \(item)")
//                        .font(.headline)
//                        .padding()
//                    
//                    Text("당신의 최대 심박: \(maxRate)")
//                        .font(.headline)
//                        .padding()
//                    Text("당신의 최소 심박: \(minRate)")
//                        .font(.headline)
//                        .padding()
//                    
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//


import SwiftUI
import HealthKit


//struct HeartRateView: View {
//    @EnvironmentObject var stopwatchManager: StopwatchManager
//    @ObservedObject var model = HeartRateModel()
//    
//    @Binding var isShowingHeartRateView: Bool
//    
//    var maxRate: Int
//    var minRate: Int
//    var item: String
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                VStack {
//                    Text("Selected Item: \(item)")
//                        .font(.headline)
//                        .padding()
//                    
//                    Text("당신의 최대 심박: \(maxRate)")
//                        .font(.headline)
//                        .padding()
//                    
//                    Text("당신의 최소 심박: \(minRate)")
//                        .font(.headline)
//                        .padding()
//                }
//                
//                CustomSlider(value: $model.heartRate, range: Double(minRate)...Double(maxRate))
//                    .frame(height: 50)
//                    .padding()
//                
//                Text("심박수: \(Int(round(model.heartRate)))")
//                    .font(.title)
//                    .padding()
//                
//                Text(stopwatchManager.formattedTime)
//                    .font(.largeTitle)
//                    .padding()
//            }
//        }
//        .onAppear {
//            stopwatchManager.start()
//        }
//        .onDisappear {
//            stopwatchManager.stop()
//        }
//    }
//}


struct HeartRateView: View {
    @StateObject var model = HeartRateModel()
    @Binding var isShowingHeartRateView: Bool
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    var body: some View {
        ScrollView {
            VStack {
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
                }
                
                CustomSlider(value: $model.heartRate, range: Double(minRate)...Double(maxRate))
                    .frame(height: 50)
                    .padding()
                
                Text("심박수: \(Int(round(model.heartRate)))")
                    .font(.title)
                    .padding()
            }
        }
    }
}


// MARK: - CustomSliderView

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
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





#Preview {
    HeartRateView(isShowingHeartRateView: .constant(true), maxRate: 200, minRate: 180,item: "")
//    HeartRateView(maxRate: 180, minRate: 140, item: "")
}

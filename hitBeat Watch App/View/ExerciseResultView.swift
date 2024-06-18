//
//  ExerciseResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI
import HealthKit

struct ExerciseResultView: View {
    
//    @ObservedObject var model = HeartRateModel()
    @ObservedObject var stopwatchManager = StopwatchManager()
    
    @State private var isShowingHeartRateView = false
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    
    var body: some View {
            Group {
                if isShowingHeartRateView {
                    HeartRateView(isShowingHeartRateView: $isShowingHeartRateView, maxRate: maxRate, minRate: minRate, item: item)
//                        .environmentObject(stopwatchManager)
//                        .environmentObject(model)
                } else {
                    VStack {
                        VStack{
                            Circle()
                                .fill(.gray)
                                .frame(height: 50)
                                .padding()
                            
                            Text("\(item)")
                            
                            Text("\(minRate) - \(maxRate)")
                                .font(.title)
                            
                            Text("심박수를 유지하세요.")
                                .font(.caption2)
                        }
                        .padding()
                        
                        Button {
//                            self.stopwatchManager.start()
                            isShowingHeartRateView.toggle()
                        } label: {
                            Rectangle()
                                .fill(Color.green)
                                .cornerRadius(10)
                                .frame(height: 50)
                        }
                        .frame(width: 100, height: 50)
                        .padding()
                    }
                }
            }
//    var body: some View {
//        VStack {
//            VStack{
//                Circle()
//                    .fill(.gray)
//                    .frame(height: 50)
//                    .padding()
//
//                Text("\(item)")
//
//                Text("\(minRate) - \(maxRate)")
//                    .font(.title)
//
//                Text("심박수를 유지하세요.")
//                    .font(.caption2)
//            }
//            .padding()
//
//            Button {
//                self.stopwatchManager.start()
//                isShowingHeartRateView.toggle()
//            } label: {
//                Rectangle()
//                    .fill(Color.green)
//                    .cornerRadius(10)
//                    .frame(height: 50)
//            }
//            .frame(width: 100, height: 50)
//            .padding()
//        }
//        .fullScreenCover(isPresented: $isShowingHeartRateView) {
//            HeartRateView(isShowingHeartRateView: $isShowingHeartRateView, maxRate: maxRate, minRate: minRate, item: item)
//                .environmentObject(stopwatchManager) // 환경 객체로 전달
//        }
    }
}


#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "운동능력")
}

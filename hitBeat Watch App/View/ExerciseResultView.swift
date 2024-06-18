//
//  ExerciseResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ExerciseResultView: View {
    @StateObject var stopwatchManager = StopwatchManager()
    
    @State private var isShowingHeartRateView = false
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    var body: some View {
        Group {
            if isShowingHeartRateView {
                VStack {
                    HeartRateView(isShowingHeartRateView: $isShowingHeartRateView, maxRate: maxRate, minRate: minRate, item: item)
                    
                    Text(stopwatchManager.formattedTime)
                        .font(.largeTitle)
                        .padding()
                }
                .onAppear {
                    stopwatchManager.start()
                }
                .onDisappear {
                    stopwatchManager.stop()
                }
            } else {
                VStack {
                    VStack {
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
                        stopwatchManager.start()
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
    }
}

#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "운동능력")
}

//
//  ExerciseResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ExerciseResultView: View {
    
    @StateObject private var stopwatchManager = StopwatchManager()
    @StateObject private var stopstopwatchManager = stopStopwatchManager()
    @StateObject private var heartRateManager = HeartRateManager()
    
    @State private var isShowingTabView = false
    @State private var isShowingResultView = false
    
    var maxRate: Int
    var minRate: Int
    var item: String
    var exerciseImage: String
    
    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
                    Image(exerciseImage)
                        .resizable()
                        .frame(width: 40,height: 40)
                        .padding()
                    
                    Text("\(item)")
                    
                    HStack(alignment: .bottom){
                        Text("\(minRate) - \(maxRate)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.hitRed)
                        
                        Text("BPM")
                            .foregroundColor(.hitRed)
                    }
                    .padding(2)
                    
                    Text("심박수를 유지하세요.")
                        .font(.caption2)
                }
                .padding()
                
                NavigationLink(destination: ExerciseTabView( isShowingResultView: $isShowingResultView, isShowingTabView: $isShowingTabView, maxRate: maxRate, minRate: minRate, item: item)
                    .environmentObject(stopwatchManager)
                    .environmentObject(stopstopwatchManager)
                    .environmentObject(heartRateManager)
                ) {
                    ZStack{
                        Rectangle()
                            .fill(.hitRed)
                            .frame(width: 160,height: 36)
                            .cornerRadius(20)
                        Text("운동시작")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                .fullScreenCover(isPresented: $isShowingResultView) {
                    AllResultView(maxRate: maxRate, minRate: minRate)
                        .environmentObject(stopwatchManager)
                        .environmentObject(stopstopwatchManager)
                        .environmentObject(heartRateManager)
                }
            }
        }
        
    }
}

#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "운동능력", exerciseImage: "photo1")
}

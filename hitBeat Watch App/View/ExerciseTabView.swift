//
//  AllResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct ExerciseTabView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var stopwatchManager: StopwatchManager
    @EnvironmentObject var stopstopwatchManager: stopStopwatchManager
    @EnvironmentObject var heartRateManager: HeartRateManager

    @State private var finalTime: String = "00:00:00"
    
    @Binding var isShowingResultView: Bool
    @Binding var isShowingTabView: Bool
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    
    var body: some View {
        
    
            TabView {
                VStack{
                    HStack{
                        Text("운동시간")
                            .font(.footnote)
                            .foregroundColor(.hitRed)
                        Spacer()
                        
                        Text(stopwatchManager.formattedTime)
                            .font(.footnote)
                            .foregroundColor(.hitYellow)
                    }
                    .padding()
                    .padding(.top,34)
                    HeartRateView(maxRate: maxRate, minRate: minRate, item: item)
                        .environmentObject(stopwatchManager)
                        .environmentObject(stopstopwatchManager)
                        .environmentObject(heartRateManager)
                }
                .tabItem {
                    Image(systemName: "circle")
                    Text("1")
                }
                //
                VStack{
                    ControllView(isShowingTabView: $isShowingTabView)
                        .environmentObject(stopwatchManager)
                        .environmentObject(stopstopwatchManager)
                        .environmentObject(heartRateManager)
                    // 닫기 버튼
                    Button{
                        stopwatchManager.finalTime = stopwatchManager.formattedTime
                        stopwatchManager.stop()
                        stopstopwatchManager.stop()
                        heartRateManager.stopTimer()
                        self.presentationMode.wrappedValue.dismiss()
                        self.isShowingResultView = true
                        
                    }label: {
                        VStack{
                            ZStack{
                                Circle()
                                    .fill(.hitRed)
                                    .opacity(0.3)
                                    .frame(width: 44,height: 44)
                                
                                
                                Image(systemName: "stop.fill")
                                    .foregroundColor(.hitRed)
                                    .frame(width: 44,height: 44)
                            }
                            Text("운동종료")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    
                    
                }
                .padding()
                .foregroundColor(.black)
                
                .tabItem {
                    Image(systemName: "circle")
                    Text("2")
                }
                
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear{
                stopwatchManager.start()
                heartRateManager.startTimer()
            }
            .navigationBarBackButtonHidden()
        
    }
}



#Preview {
    ExerciseTabView(isShowingResultView: .constant(false), isShowingTabView: .constant(true), maxRate: 130, minRate: 90, item: "")
        .environmentObject(StopwatchManager())
        .environmentObject(stopStopwatchManager())
        .environmentObject(HeartRateManager())
}

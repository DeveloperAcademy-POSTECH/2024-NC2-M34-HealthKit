//
//  SwiftUIView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct ControllView: View {
    
    @EnvironmentObject var stopwatchManager: StopwatchManager
    @EnvironmentObject var stopstopwatchManager: stopStopwatchManager

    @State private var isShowingResultView = false
    
    @Binding var isShowingTabView: Bool
    
    var body: some View {
        
        
            if stopwatchManager.isRunning{
                    
                    VStack{
                        HStack{
                            
                            
                            Spacer()
                            
                            Text("운동중")
                                .font(.footnote)
                                .foregroundColor(.hitRed)
                            
                        }
    //                    .padding(.top,14)
//                        .padding(.horizontal)
                    
                    Button{
//                        stopwatchManager.pause()
                        stopwatchManager.isRunning = false
                        stopstopwatchManager.start()
                    }label: {
                        VStack{
                            ZStack{
                                Circle()
                                    .fill(.hitYellow)
                                    .opacity(0.3)
                                    .frame(width: 44,height: 44)
                                
                                
                                Image(systemName: "pause")
                                    .foregroundColor(.hitYellow)
                                    .frame(width: 44,height: 44)
                            }
                            Text("일시 정지")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    
                    
                    
                }
                
                
            }else{
                VStack{
                    HStack{
                        
                        Text(stopstopwatchManager.formattedTime)
                            .font(.footnote)
                            .foregroundColor(.hitYellow)
                        
                        Spacer()
                        
                        Text("일시 정지됨")
                            .font(.footnote)
                            .foregroundColor(.hitRed)
                        
                    }
//                    .padding(.top,14)
//                    .padding(.horizontal)
                    
                    
                    Button{
//                        stopwatchManager.resume()
                        stopwatchManager.isRunning = true
                        stopstopwatchManager.stop()
                    }label: {
                        VStack{
                            ZStack{
                                Circle()
                                    .fill(.hitYellow)
                                    .opacity(0.3)
                                    .frame(width: 44,height: 44)
                                
                                
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(.hitYellow)
                                    .frame(width: 44,height: 44)
                            }
                            Text("운동 재개")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    
                    
                    
                    
                    
                    
                    
                    
                    
                
            }
            
        }
        
        
        
        
    }
}


#Preview {
    ControllView( isShowingTabView: .constant(true))
        .environmentObject(StopwatchManager())
        .environmentObject(stopStopwatchManager())
}

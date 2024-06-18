//
//  AllResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct ExerciseTabView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var model = HeartRateModel()
    @StateObject var stopwatchManager = StopwatchManager()

    
    @Binding var isShowingTabView: Bool
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    
    var body: some View {
        TabView {
            
            ScrollView(){
                HStack{
                    Spacer()
                    Text(stopwatchManager.formattedTime)
                        .foregroundColor(.hitYellow)
                }
                HeartRateView(maxRate: maxRate, minRate: minRate, item: item)
                
            }
                .tabItem {
                    Image(systemName: "circle")
                    Text("1")
                }
            
            
                    
            Text("컨드롤뷰")
                .tabItem {
                    Image(systemName: "circle")
                    Text("2")
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear{
                stopwatchManager.start()
            }
    }
}

#Preview {
    ExerciseTabView(isShowingTabView: .constant(true), maxRate: 130, minRate: 90, item: "")
}

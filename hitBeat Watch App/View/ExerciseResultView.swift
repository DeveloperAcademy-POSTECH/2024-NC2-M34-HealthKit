//
//  ExerciseResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ExerciseResultView: View {
    
    
    @State private var isShowingTabView = false
    @State private var isShowingResultView = false
    
    var maxRate: Int
    var minRate: Int
    var item: String
    
    var body: some View {
        
        VStack {
            VStack {
                Circle()
                    .fill(.gray)
                    .frame(height: 50)
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
            
            Button {
                isShowingTabView.toggle()
            } label: {
                ZStack{
                    Rectangle()
                        .fill(.hitRed)
                        .frame(width: 160,height: 36)
                        .cornerRadius(20)
                    Text("운동시작")
                }
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $isShowingTabView) {
                ExerciseTabView( isShowingResultView: $isShowingResultView, isShowingTabView: $isShowingTabView, maxRate: maxRate, minRate: minRate, item: item)
            }
            .fullScreenCover(isPresented: $isShowingResultView) {
                        AllResultView()
                    }
        }
        
    }
}

#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "운동능력")
}

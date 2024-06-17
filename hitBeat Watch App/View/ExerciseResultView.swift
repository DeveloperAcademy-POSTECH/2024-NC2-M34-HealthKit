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
        
        NavigationStack {
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
                
                
                NavigationLink(destination: HeartRateView(maxRate: maxRate, minRate: minRate, item: item)) {
                    
                    ZStack{
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 180,height: 36)
                            .cornerRadius(15)
                        Text("Next")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}


#Preview {
    ExerciseResultView(maxRate: 200, minRate: 120, item: "운동능력")
}

//
//  ExerciseListView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ExerciseListView: View {
    
    var highHeart: Int
    var age: Int
    
    var exerciseLists = [
        exerciseData(name: "최강도", comment: "운동능력향상", minpercent: 0.85, maxpercent: 1),
        exerciseData(name: "고강도", comment: "심폐지구력", minpercent: 0.7, maxpercent: 0.85),
        exerciseData(name: "중강도", comment: "다이어트", minpercent: 0.6, maxpercent: 0.7),
        exerciseData(name: "저강도", comment: "운동 초보자 모드", minpercent: 0.1, maxpercent: 0.6)
        
    ]
    var body: some View {

        NavigationStack {
            List(exerciseLists) { exercise in
                NavigationLink(destination: ExerciseResultView(maxRate: Int(round(Float(highHeart) * (exercise.maxpercent))), minRate:  Int(round(Float(highHeart) * (exercise.minpercent))),item: exercise.comment)) 
                {
                    HStack(spacing: 0){
                        Circle()
                            .frame(height: 30)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text(exercise.comment)
                                .font(.title3)
                            Text(exercise.name)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    ExerciseListView(highHeart: 200 , age: 20)
}

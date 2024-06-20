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
        exerciseData(name: "고강도", comment: "운동능력향상", minpercent: 0.85, maxpercent: 1,exerciseImage: "photo1"),
        exerciseData(name: "중강도", comment: "심폐지구력", minpercent: 0.7, maxpercent: 0.85,exerciseImage: "photo2"),
        exerciseData(name: "저,중강도", comment: "다이어트", minpercent: 0.6, maxpercent: 0.7,exerciseImage: "photo3"),
        exerciseData(name: "저강도", comment: "운동 초보자 모드", minpercent: 0.5, maxpercent: 0.6,exerciseImage: "photo4")
        
    ]
    var body: some View {

        NavigationStack {
            List(exerciseLists) { exercise in
                NavigationLink(destination: ExerciseResultView(maxRate: Int(round(Float(highHeart) * (exercise.maxpercent))), minRate:  Int(round(Float(highHeart) * (exercise.minpercent))),item: exercise.name, exerciseImage: exercise.exerciseImage)) 
                {
                    HStack(spacing: 0){
                        Image(exercise.exerciseImage)
                            .resizable()
                            .frame(width: 24,height: 24)
                            .padding(.trailing,2)
                            .padding(.horizontal)
                        
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

//
//  ContentView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var age = 20
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView{
                    
                    VStack(spacing: 0){
                        Text("나이입력")
                            .font(.caption)
                            .frame(alignment: .center)
                            .bold()
                            .padding()
                        
                        Text("운동목적에 따라 효과적인 심박수를 유지하면 최대의 운동효과를 \n기대할 수 있습니다.")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        
                        HStack(alignment: .bottom){
                            
                            Button{
                                age -= 1
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 40,height: 40)
                                    
                                    Image(systemName: "minus")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            
                            Text("만")
                                .font(.footnote)
                                .offset(CGSize(width: -2, height: -5))
                            
                            Text("\(age)")
                                .font(.title2)
                            
                            Text("세")
                                .font(.footnote)
                                .offset(CGSize(width: 2, height: -5))
                            Spacer()
                            
                            Button{
                                age += 1
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 40,height: 40)
                                    
                                    Image(systemName: "plus")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                        .padding()
                        
//                        TextField("Enter number", value: $age, formatter: formatter)
                        NavigationLink(destination: ExerciseListView(highHeart: (220 - age), age: age)) {
                            
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
    }
}

#Preview {
    ContentView()
}

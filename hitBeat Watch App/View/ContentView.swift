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
                            .font(.title3)
                            .frame(alignment: .center)
                            .bold()
                            .padding(.bottom,28)
                        
                        
                        HStack(alignment: .bottom){
                            
                            Button{
                                age -= 1
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(.backRed)
                                        .frame(width: 36,height: 36)
                                    
                                    Image(systemName: "minus")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
//                            .padding(.horizontal)
                            
                            Spacer()
                            
                            Text("만")
                                .font(.footnote)
                                .offset(CGSize(width: -2, height: -5))
                            
                            Text("\(age)")
                                .font(.title)
                            
                            Text("세")
                                .font(.footnote)
                                .offset(CGSize(width: 2, height: -5))
                            
                            Spacer()
                            
                            Button{
                                age += 1
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(.backRed)
                                        .frame(width: 36,height: 36)
                                    
                                    Image(systemName: "plus")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
//                            .padding(.horizontal)
                            
                        }
                        .padding(.bottom,44)
                        
                        NavigationLink(destination: ExerciseListView(highHeart: (220 - age), age: age)) {
                            ZStack{
                                Rectangle()
                                    .fill(.hitRed)
                                    .frame(width: 160,height: 36)
                                    .cornerRadius(20)
                                Text("다음")
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

//
//  ContentView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        VStack {
            NavigationStack {
                
                Text("자신의 나이를 입력하시오.")
                
                TextField("Enter number", value: $inputValue, formatter: formatter)
                NavigationLink(destination: ExerciseListView(highHeart: (220 - inputValue), age: inputValue)) {
                        Text("확인")
                    }
                }
                .navigationTitle("exercise")
            }
            
            
            
    }
        
}
#Preview {
    ContentView()
}

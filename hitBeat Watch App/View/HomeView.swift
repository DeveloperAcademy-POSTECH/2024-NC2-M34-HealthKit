//
//  HomeView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                HStack{
                    Image("Logo")
                    
                    Text("   ")
                }
                .padding()
                .padding(.bottom)
                
                Text("운동목적에 따라 효과적인 심박수를 유지하면 최대의 운동효과를 기대할 수 있습니다.")
                    .font(.footnote)
                    .padding(.horizontal,8)
                    .padding(.bottom,26)
                    
                
                
                NavigationLink(destination: ContentView()) {
                    
                    ZStack{
                        Rectangle()
                            .fill(.hitRed)
                            .frame(width: 160,height: 36)
                            .cornerRadius(20)
                        Text("시작")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    HomeView()
}

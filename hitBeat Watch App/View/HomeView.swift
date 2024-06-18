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
                
                Text("HIT BEAT")
                    .font(.title2)
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

//struct HomeView: View {
//    @State private var isModalPresented = false
//    
//    var body: some View {
//        ZStack {
//            // 배경 뷰
//            Color.black.edgesIgnoringSafeArea(.all)
//            
//            // 모달 버튼
//            Button("Show Modal") {
//                self.isModalPresented.toggle()
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isModalPresented) {
//            ModalView()
//        }
//    }
//}
//
//struct ModalView: View {
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        ZStack {
//            // 모달 내용
//            Color.yellow.edgesIgnoringSafeArea(.all)
//            
//            // 닫기 버튼
//            Button("Close") {
//                self.presentationMode.wrappedValue.dismiss()
//            }
//            .padding()
//            .foregroundColor(.black)
//        }
//    }
//}


#Preview {
    HomeView()
}

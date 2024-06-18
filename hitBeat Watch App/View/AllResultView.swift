//
//  AllResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct AllResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            Text("")
            
            Button{
                self.presentationMode.wrappedValue.dismiss()
                
            }label: {
                Text("닫기")
            }
        }
        .background(.black)
    }
}

#Preview {
    AllResultView()
}

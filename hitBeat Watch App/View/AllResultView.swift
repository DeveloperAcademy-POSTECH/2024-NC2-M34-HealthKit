//
//  AllResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI

struct AllResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var stopwatchManager: StopwatchManager
    
    var body: some View {
        VStack{
            Text("\(stopwatchManager.finalTime)")
            
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

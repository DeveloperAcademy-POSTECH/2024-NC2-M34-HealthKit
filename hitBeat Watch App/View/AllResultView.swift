//
//  AllResultView.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import SwiftUI
import Charts

struct AllResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var stopwatchManager: StopwatchManager
    @EnvironmentObject var heartRateManager: HeartRateManager
    
    var maxRate: Int
    var minRate: Int
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                HStack{
                    Spacer()
                    
                    Text("결과")
                        .font(.footnote)
                        .foregroundColor(.hitRed)
                }
                
                HStack(alignment: .bottom){
                    Text(" \(Int(round(heartRateManager.heartSum())) / heartRateManager.heartRateHistory.count)")
                        .font(.title)
                        .foregroundColor(.hitRed)
                        .bold()
                    
                    Text("BPM")
                        .foregroundColor(.hitRed)
                    
                    Spacer()
                    
                }
                
                
                // 선 그래프
                VStack{
                    Text("")
                    Chart{
                        ForEach(heartRateManager.heartRateHistory.indices ,id: \.self){ index in
                            LineMark(
                                x: .value("x", index),
                                y: .value("y", heartRateManager.heartRateHistory[index]))
                            
                        }
                        .foregroundStyle(Color.hitRed)
                        
                        RuleMark(y: .value("Threshold", maxRate))
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundStyle(Color.hitRed)
                            .opacity(0.3)
                            .annotation(position: .top, alignment: .leading) {
                                Text("\(maxRate)")
                                    .font(.footnote)
                                    .foregroundColor(.hitRed)
                                    .opacity(0.3)
                            }
                        RuleMark(y: .value("Threshold", minRate))
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundStyle(Color.hitRed)
                            .opacity(0.3)
                            .annotation(position: .top, alignment: .leading) {
                                Text("\(minRate)")
                                    .font(.footnote)
                                    .foregroundColor(.hitRed)
                                    .opacity(0.3)
                            }
                        
                    }
                }
                .padding()
                
                VStack(alignment: .leading){
                    
                    Text("총 운동시간")
                    
                    HStack{
                        
                        Text("\(stopwatchManager.finalTime)")
                            .foregroundColor(.hitYellow)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                }
                .padding()
                
                VStack(alignment: .leading){
                    Text("심박수 범위")
                    
                    HStack{
                        Text("\(Int(round(heartRateManager.heartRateHistory.min()!))) ~ \(Int(round(heartRateManager.heartRateHistory.max()!))) BPM")
                            .foregroundColor(.hitRed)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                }
                .padding()
            
                Button{
                    self.presentationMode.wrappedValue.dismiss()
                    
                }label: {
                    ZStack{
                        Rectangle()
                            .fill(.hitRed)
                            .frame(width: 160,height: 36)
                            .cornerRadius(20)
                        Text("확인")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(.black)
    }
}

struct LineGraph: Shape {
    var dataPoints: [Double]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard dataPoints.count > 1 else { return path }

        let stepX = rect.width / CGFloat(dataPoints.count - 1)
        let maxY = dataPoints.max() ?? 1
        let scaleY = rect.height / maxY

        path.move(to: CGPoint(x: 0, y: rect.height - dataPoints[0] * scaleY))

        for index in 1..<dataPoints.count {
            let x = stepX * CGFloat(index)
            let y = rect.height - dataPoints[index] * scaleY
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }
}

#Preview {
    AllResultView(maxRate: 100, minRate: 60)
        .environmentObject(StopwatchManager())
        .environmentObject(HeartRateManager())
}

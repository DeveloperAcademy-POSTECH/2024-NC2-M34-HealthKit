//
//  StopwatchManager.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI
import Combine

class StopwatchManager: ObservableObject {
    @Published var formattedTime: String = "00:00:00"
    
    private var timer: Timer?
    private var startTime: Date?
    
    func start() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTime() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60 % 60
        let seconds = Int(elapsedTime) % 60
        DispatchQueue.main.async {
            self.formattedTime = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        }
    }
}

//
//class StopwatchManager: ObservableObject {
//    @Published var secondsElapsed = 0.0
//    
//    var timer: AnyCancellable?
//    var isRunning = false
//    
//    func start() {
//        if !isRunning {
//            isRunning = true
//            timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect().sink { _ in
//                self.secondsElapsed += 0.1
//            }
//        }
//    }
//    
//    func pause() {
//        timer?.cancel()
//        isRunning = false
//    }
//    
//    func reset() {
//        timer?.cancel()
//        isRunning = false
//        secondsElapsed = 0.0
//    }
//    
//    var formattedTime: String {
//        let hours = Int(secondsElapsed) / 3600
//        let minutes = (Int(secondsElapsed) % 3600) / 60
//        let seconds = Int(secondsElapsed) % 60
//        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
//    }
//}

//
//  StopwatchManager.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI
import Combine

//class StopwatchManager: ObservableObject {
//    @Published var formattedTime: String = "00:00:00"
//    @Published var isRunning: Bool = false
//    
//    private var timer: Timer?
//    private var startTime: Date?
//    private var pausedTime: TimeInterval = 0
//    private var elapsedTime: TimeInterval = 0
//    
//    func start() {
//        guard !isRunning else { return }  // 이미 실행 중이면 무시
//        if startTime == nil {
//            startTime = Date()
//        } else {
//            // Adjust startTime by subtracting the paused duration
//            startTime = Date().addingTimeInterval(-pausedTime)
//        }
//        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            self?.updateTime()
//        }
//        isRunning = true
//        pausedTime = 0
//    }
//    
//    func stop() {
//        timer?.invalidate()
//        timer = nil
//        isRunning = false
//        startTime = nil
//        pausedTime = 0
//        elapsedTime = 0
//        DispatchQueue.main.async {
//            self.formattedTime = "00:00:00"
//        }
//    }
//    
//    func pause() {
//        guard isRunning else { return }  // 실행 중이 아니면 무시
//        timer?.invalidate()
//        timer = nil
//        isRunning = false
//        if let startTime = startTime {
//            pausedTime = Date().timeIntervalSince(startTime) - elapsedTime
//        }
//    }
//    
//    private func updateTime() {
//        guard let startTime = startTime else { return }
//        elapsedTime = Date().timeIntervalSince(startTime)
//        let totalElapsedTime = elapsedTime + pausedTime
//        let hours = Int(totalElapsedTime) / 3600
//        let minutes = Int(totalElapsedTime) / 60 % 60
//        let seconds = Int(totalElapsedTime) % 60
//        DispatchQueue.main.async {
//            self.formattedTime = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
//        }
//    }
//}


import Foundation
import Combine

class StopwatchManager: ObservableObject {
    @Published var formattedTime: String = "00:00:00"
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false
    
    private var timer: Timer?
    private var startTime: Date?
    private var pausedTime: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    
    func start() {
        guard !isRunning else { return }  // 이미 실행 중이면 무시
        startTime = Date().addingTimeInterval(-pausedTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
        isRunning = true
        isPaused = false
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isPaused = false
        startTime = nil
        pausedTime = 0
        elapsedTime = 0
        DispatchQueue.main.async {
            self.formattedTime = "00:00:00"
        }
    }
    
    func pause() {
        guard isRunning && !isPaused else { return }  // 실행 중이 아니거나 이미 일시정지 상태이면 무시
        timer?.invalidate()
        timer = nil
        isPaused = true
        if let startTime = startTime {
            pausedTime += Date().timeIntervalSince(startTime)
        }
    }
    
    func resume() {
        guard isPaused else { return }  // 일시정지 상태가 아니면 무시
        startTime = Date().addingTimeInterval(-pausedTime)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
        isPaused = false
    }
    
    private func updateTime() {
        guard let startTime = startTime else { return }
        elapsedTime = Date().timeIntervalSince(startTime)
        let totalElapsedTime = elapsedTime + pausedTime
        pausedTime = 0
        let hours = Int(totalElapsedTime) / 3600
        let minutes = Int(totalElapsedTime) / 60 % 60
        let seconds = Int(totalElapsedTime) % 60
        DispatchQueue.main.async {
            self.formattedTime = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        }
    }
}

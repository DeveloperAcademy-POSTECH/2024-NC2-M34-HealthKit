//
//  stopStopvwatchManager.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/18/24.
//

import Foundation
import SwiftUI
import Combine

class stopStopwatchManager: ObservableObject {
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

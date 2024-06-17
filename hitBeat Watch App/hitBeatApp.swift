//
//  hitBeatApp.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import SwiftUI

@main
struct hitBeat_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            HeartRateView(maxRate: 120, minRate: 10, item: "")
        }
    }
}

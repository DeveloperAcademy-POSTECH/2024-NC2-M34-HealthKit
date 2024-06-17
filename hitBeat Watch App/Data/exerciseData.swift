//
//  exerciseData.swift
//  hitBeat Watch App
//
//  Created by 정혜정 on 6/17/24.
//

import Foundation

struct exerciseData: Identifiable{
    var id = UUID()
    var name: String
    var comment: String
    var minpercent: Float
    var maxpercent: Float
}

//
//  Item.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import Foundation
import SwiftData
import SwiftUI
internal import Combine

enum ItemType: String, Codable, CaseIterable {
    case increasing = "Increasing"
    case decreasing = "Decreasing"
    case oneTime = "One Time"
}

@Model
final class Item {
    
    var id: UUID
    var name: String
    var target: Double?
    var dailyUsage: Double
    var singleProgressValue: Double?
    var adaiMozhi: String
    var overAllUsage: TotalConsumption
    var dayWiseProgress: [DayWiseStatus]
    var type: ItemType
    var currentDate: Date
    
    init(id: UUID = UUID(), name: String = "", target: Double? = nil, dailyUsage: Double = 0.0,singleProgressValue: Double? = nil,adaiMozhi: String = "", overAllUsage: TotalConsumption = TotalConsumption(), dayWiseProgress: [DayWiseStatus] = [], type: ItemType = .increasing, currentDate:Date = Date()) {
        self.id = id
        self.name = name
        self.target = target
        self.dailyUsage = dailyUsage
        self.singleProgressValue = singleProgressValue
        self.adaiMozhi = adaiMozhi
        self.overAllUsage = overAllUsage
        self.dayWiseProgress = dayWiseProgress
        self.type = type
        self.currentDate = currentDate
    }
}

@Model
final class DayWiseStatus {
    var amountCompleted: Double
    var date: Date
    
    init(amountCompleted: Double = 0.0, date: Date = Date()) {
        self.amountCompleted = amountCompleted
        self.date = date
    }
}

@Model
final class TotalConsumption {
    var totalAmount: Double
    var date = Date()
    init(totalAmount: Double = 0.0) {
        self.totalAmount = totalAmount
    }
}

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
}

//
//  ChartView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 08/03/26.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @State var dailyProgress: [DayWiseStatus]

    var body: some View {
        Chart {
            ForEach(Array(dailyProgress.enumerated()), id: \.offset) { index, element in
                LineMark(x: .value("", element.date ),y: .value("", element.amountCompleted ))
                BarMark(x: .value("", element.date ),y: .value("", element.amountCompleted ))
            }
        }
        .frame(width: 360, height: 300, alignment: .bottom)
    }
}

#Preview {
//    var dailyProgress: [DayWiseStatus] = []
//    
//    func dayOffset(_ index: Int) -> Date {
//        Calendar.current.date(byAdding: .day, value: index, to: Date()) ?? Date()
//    }
//    
//    
//    dailyProgress.append(DayWiseStatus(amountCompleted: 200, date: Date()))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 220, date: dayOffset(1)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 180, date: dayOffset(2)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 170, date: dayOffset(3)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 160, date: dayOffset(4)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 190, date: dayOffset(5)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 220, date: dayOffset(6)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 200, date: dayOffset(7)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 170, date: dayOffset(8)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 190, date: dayOffset(9)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 175, date: dayOffset(10)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 189, date: dayOffset(11)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 135, date: dayOffset(12)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 167, date: dayOffset(13)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 197, date: dayOffset(14)))
//    dailyProgress.append(DayWiseStatus(amountCompleted: 178, date: dayOffset(15)))
//    
//    return ChartView(dailyProgress: dailyProgress)
}

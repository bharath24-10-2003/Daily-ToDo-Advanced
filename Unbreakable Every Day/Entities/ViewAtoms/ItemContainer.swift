//
//  ItemContainer.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI

struct ItemContainer: View {

    var item:Item
    
    var body: some View {
        VStack {
            Spacer()
            Text(item.name)
                .fontWeight(.black)
                .fontDesign(.rounded)
                .fontWidth(.expanded)
            Spacer()
            HStack (alignment: .center){
                Spacer(minLength: 10)
                ProgressImageView(progress: item.dailyUsage / (item.target ?? 0))
                ProgressDetailsView(item: item)
                    .frame(width: 135)
            }
            .frame(width: 175, height: 170, alignment: .center)
        }
        .frame(height: 220)
        .glassEffect(.clear,in: RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)))
        .shadow(color: .white, radius: 1)
        .onAppear {
            resetItemOnNewDay()
        }
    }
    
    func resetItemOnNewDay() {
        let itemDate = item.currentDate
        let currentDate = Date()
        
        if !Calendar.current.isDate(itemDate, inSameDayAs: currentDate) {
            item.overAllUsage.totalAmount += item.dailyUsage
            item.dayWiseProgress.append(DayWiseStatus(amountCompleted: item.dailyUsage,date: item.currentDate))
            item.dailyUsage = 0.0
            item.currentDate = Date()
        }
    }
}

struct ProgressImageView:View {
    var progress: Double
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .bottom){
                Rectangle()
                    .clipShape(.capsule)
                    .glassEffect()
                    .frame(width: 50, height: 155)
                Rectangle()
                    .colorInvert()
                    .clipShape(.capsule)
                    .frame(width: 48,height: max(151 * progress, 0))
                    .animation(.linear,value: 0.5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    .glassEffect(.regular)
                    .overlay {
                        Text("\(Int(progress * 100))%")
                            .fontWeight(.semibold)
                    }
            }
        }
    }
}

struct ProgressDetailsView:View {
    var item: Item
    var body: some View {
        VStack (alignment: .leading){
            TextDesc(title: "Target", desc: String(item.target ?? 0.0))
            TextDesc(title: "Progress", desc: String(item.dailyUsage))
            TextDesc(title: "Life Time", desc: String(item.overAllUsage.totalAmount))
        }
    }
}

struct TextDesc: View {
    var title: String
    var desc: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text(title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .lineLimit(1)
            Text(desc)
                .fontDesign(.rounded)
                .lineLimit(2)
            Spacer()
        }
    }
}

#Preview {
    let dummyItem: Item = Item(name: "Dummy", target: 200, type: .increasing)
    dummyItem.dailyUsage = 200
    return ItemContainer(item: dummyItem)
}

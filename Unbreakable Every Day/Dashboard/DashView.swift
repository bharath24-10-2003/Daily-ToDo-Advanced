//
//  DashView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI
import SwiftData

struct DashView:View {
//    @Environment(\.modelContext)  private var context
//    @Query var items: [Item]
    let columns = [ GridItem(.flexible()),GridItem(.flexible())]
    
    let items:[Item]
    @State var selectedItem: Item? = nil
    
    var viewModel = DashViewModel()
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 20) {
                ForEach(items) { item in
                    ItemContainer(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
            }
            .overlay(alignment: .center) {
                if selectedItem != nil {
//                    ProgressSelectionView(selectedItem: $selectedItem)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct ProgressSelectionView: View {
    @State var selectedItem: Item?
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(selectedItem?.name ?? "")
                .fontWeight(.black)
            Spacer()
            ProgressSelectionBodyView(item: selectedItem,showAlert: $showAlert)
            Spacer()
            ProgressActionsBottomView(item: selectedItem,showAlert: $showAlert)
            Spacer()
        }
        .frame(width: 300,height: 500,alignment: .center)
        .glassEffect(.clear,in: RoundedRectangle(cornerSize: CGSize(width: 35, height: 35)))
    }
}

struct ProgressSelectionBodyView: View {
    @State var item: Item?
    @Binding var showAlert: Bool
    @State var amount: Double? = nil
    var body: some View {
        VStack (alignment: .leading) {
            Text("Today's Progress: \(Int(item?.dailyUsage ?? 0.0))")
            Text("Target: \(Int(item?.target ?? 0))")
            Text("Today: ")
            Text("LifeTime: \(Int(item?.overAllUsage.totalAmount ?? 0))")
            Text("")
        }
        .frame(width: 450,height: 300)
        .overlay {
            if showAlert {
                VStack {
                    Spacer()
                    TextField("Enter Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 150,height: 40,alignment: .center)
                        .glassEffect()
                    Spacer(minLength: 20)
                    HStack{
                        Spacer()
                        Button("Cancel") {
                            amount = nil
                            showAlert = false
                        }
                        .buttonStyle(.glass)
                        .tint(.red)
                        Spacer()
                        Button("Add") {
                            item?.dailyUsage += amount ?? 0.0
                            amount = nil
                            showAlert = false
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.blue)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 200,height: 120)
                .background(in: RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .circular))
            }
        }
    }
}

struct ProgressActionsBottomView: View {
    @State var item: Item?
    @Binding var showAlert: Bool

    var body: some View {
        HStack {
            Button("Add Manually") {
                showAlert = true            }
            .buttonStyle(.glass)
            if let singleProgressValue = item?.singleProgressValue {
                Button("Add \(Int(singleProgressValue))\(item?.adaiMozhi ?? "")") {
                    item?.dailyUsage += item?.singleProgressValue ?? 0.0
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}

#Preview {
    var dummyItem: Item = Item(name: "Dummy", target: 200, type: .increasing)
    dummyItem.singleProgressValue = 200
    dummyItem.adaiMozhi = "Rs"
    return ProgressSelectionView(selectedItem: dummyItem)
}

//#Preview {
//    var dummyItems: [Item] = []
//    var dummyItem: Item = Item(name: "Dummy", target: 200, type: .increasing)
//    let dummyItem1: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem2: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem3: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem4: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem5: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem6: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem7: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem8: Item = Item(name: "dummy", target: 200, type: .increasing)
//    let dummyItem9: Item = Item(name: "dummy", target: 200, type: .increasing)
//    
//    dummyItem.dailyUsage = 150
//    dummyItem.overAllUsage.totalAmount = 3000
//
//    dummyItems.append(dummyItem)
//    dummyItems.append(dummyItem1)
//    dummyItems.append(dummyItem2)
//    dummyItems.append(dummyItem3)
//    dummyItems.append(dummyItem4)
//    dummyItems.append(dummyItem5)
//    dummyItems.append(dummyItem6)
//    dummyItems.append(dummyItem7)
//    dummyItems.append(dummyItem8)
//    dummyItems.append(dummyItem9)
//    
//    return DashView(items: dummyItems)
//}

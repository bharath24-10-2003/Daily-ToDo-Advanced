//
//  DashView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI
import SwiftData

struct DashView:View {
    @Environment(\.modelContext)  private var context
    @Query var items: [Item]
    let columns = [ GridItem(.flexible()),GridItem(.flexible())]
    
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
                    ProgressSelectionView(selectedItem: $selectedItem)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct ProgressSelectionView: View {
    @Binding var selectedItem: Item?
    @State var showAlert: Bool = false
    
    var body: some View {
        if let item = selectedItem {
            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Button {
                        selectedItem = nil
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.system(size: 25))
                    }
                    .frame(width: 35)

                    Text(item.name)
                        .fontWeight(.black)
                        .frame(width: 200)

                    Spacer()
                    Spacer()
                }

                Spacer()

                ProgressSelectionBodyView(item: item, showAlert: $showAlert)

                Spacer()

                ProgressActionsBottomView(item: item, showAlert: $showAlert)

                Spacer()
            }
            .frame(width: 300, height: 300)
            .glassEffect(.regular, in: RoundedRectangle(cornerSize: CGSize(width: 35, height: 35)))
        }
    }
}

struct ProgressSelectionBodyView: View {
    var item: Item
    @Binding var showAlert: Bool
    @State var amount: Double? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            InfoRow(title: "Today's Progress", value: "\(Int(item.dailyUsage))")
            InfoRow(title: "Target", value: "\(Int(item.target ?? 0))")
            InfoRow(title: "Completion Rate", value: "\(Int(item.successRate()))")
            InfoRow(title: "LifeTime", value: "\(Int(item.overAllUsage.totalAmount))")
        }
        .frame(width: 250, height: 80)
        .padding()
        .overlay {
            if showAlert {
                VStack {
                    Spacer()
                    TextField("Enter Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 150, height: 40)
                        .glassEffect()
                    Spacer(minLength: 20)
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            amount = nil
                            showAlert = false
                        }
                        .buttonStyle(.glass)
                        .tint(.red)
                        Spacer()

                        Button("Add") {
                            item.dailyUsage += amount ?? 0
                            amount = nil
                            showAlert = false
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.blue)

                        Spacer()
                    }

                    Spacer()
                }
                .frame(width: 200, height: 120)
                .background(in: RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}

struct ProgressActionsBottomView: View {
    var item: Item
    @Binding var showAlert: Bool

    var body: some View {
        HStack {
            Button("Add Manually") {
                showAlert = true
            }
            .buttonStyle(.glass)

            if let value = item.singleProgressValue {
                Button("Add \(Int(value))\(item.adaiMozhi)") {
                    item.dailyUsage += value
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}

#Preview {
//    var dummyItem: Item = Item(name: "Dummy", target: 200, type: .increasing)
//    dummyItem.singleProgressValue = 200
//    dummyItem.adaiMozhi = "Rs"
//    return ProgressSelectionView(selectedItem: dummyItem)
}

#Preview {
    DashView()
}

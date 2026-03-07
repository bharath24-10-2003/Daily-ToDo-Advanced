//
//  ItemDetailsView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 05/03/26.
//

import SwiftUI
import SwiftData

struct ItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State var item: Item
    @State var showAlert: Bool = false
    @State var showSuccess: Bool = false
    @State var onOverlayAppear = false
    var body: some View {
        let alert = Alert(title: Text("      Do you really want to exit? \n  Your progress will not be saved"), primaryButton: .default(Text("Return")), secondaryButton: .destructive(Text("Confirm Exit")) {
            dismiss()
        })
        VStack{
            Text("Create New Item")
                .font(Font(CTFont(.emphasizedSystem, size: 30)))
                .fontWeight(.bold)
            List{
                TextField("Enter Title", text: $item.name)
                TextField(
                    "Enter The Target Amount",
                    value: $item.target,
                    format: .number
                )
                .keyboardType(.decimalPad)
                TextField(
                    "Enter The Single Progress Value (Optional)",
                    value: $item.singleProgressValue,
                    format: .number
                )
                .keyboardType(.decimalPad)
                TextField("Enter The Unit of the Quantity",text: $item.adaiMozhi)
                Picker("Select Progress Type", selection: $item.type) {
                    ForEach(ItemType.allCases,id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
            }
            HStack {
                Button {
                    showAlert = true
                } label: {
                    Text("Cancel")
                        .fontWeight(.black)
                        .frame(width: 100,height: 30)
                }
                .alert(isPresented: $showAlert) {
                    alert
                }
                .buttonStyle(.glassProminent)
                .tint(.red)
                .padding()
                Button {
                    saveItemAndExit()
                } label: {
                    Text("Save")
                        .fontWeight(.black)
                        .frame(width: 100,height: 30)
                }
                .buttonStyle(.glassProminent)
                .tint(.green)
                .padding()
            }
        }
        .overlay {
            if showSuccess {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .glassEffect()
                        .scaleEffect(onOverlayAppear ? 1 : 0)
                        .opacity(onOverlayAppear ? 1 : 0)

                    Image(systemName: "checkmark")
                        .font(.system(size: 100))
                        .colorMultiply(.green)
                        .scaleEffect(onOverlayAppear ? 1 : 0)
                }
                .animation(.bouncy(duration: 0.3), value: onOverlayAppear)
                .onAppear {
                    onOverlayAppear = true
                }
            }
        }
    }

    func saveItemAndExit() {
        context.insert(item)
        showSuccess = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            dismiss()
        }
    }
}

#Preview {
    var item: Item = Item()
    ItemDetailsView(item: item)
}

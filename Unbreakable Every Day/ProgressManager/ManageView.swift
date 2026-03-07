//
//  ProgressView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI
import SwiftData

struct ManageView: View {
    @Environment(\.modelContext)  private var context
    @Query var items: [Item]
    
    var viewModel = ManageViewModel()
    var body: some View {
        NavigationStack {
            ManageTopView(count: items.count)
                .frame(maxWidth: .infinity,maxHeight: 50,alignment: .trailing)
            ManageBodyView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

struct ManageTopView: View {
    var count:Int
    var body: some View {
        HStack{
            Text("Total Items: \(count)")
            Spacer()
            NavigationLink {
                @State var item: Item = Item()
                ItemDetailsView(item: item)
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.glassProminent)
            .clipShape(Capsule())
            .tint(.green)
        }
    }
    
    func createNewItem() {
        @State var item: Item = Item()
    }
}

struct ManageBodyView: View {
    @Environment(\.modelContext)  private var context
    @Query var items: [Item]
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    ItemDetailsView(item: item)
                } label: {
                    Text(item.name)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        removeListItem(item: item)
                    }
                }
            }
        }
    }
    
    func removeListItem(item: Item) {
        context.delete(item)
    }
}

//
//  TimeSelectionListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import SwiftUI

struct TimeSelectionListView<Item: TimeSelectable, ContentView: View>: View {
    @Binding var items: [Item]
    let contentView: (Binding<Item>) -> ContentView
    let addItem: () -> Void
    let removeItem: (IndexSet) -> Void

    var body: some View {
        List {
            ForEach($items, id: \.id) { item in
                contentView(item)
            }
            .onDelete(perform: removeItem)

            Button(action: addItem) {
                Label("追加", systemImage: "plus.circle.fill")
            }
        }
        .listStyle(PlainListStyle())
    }
}

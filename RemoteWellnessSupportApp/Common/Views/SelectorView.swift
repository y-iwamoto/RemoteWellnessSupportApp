//
//  SelectorView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/22.
//

import SwiftUI

struct SelectorView<Item: SelectableItem>: View {
    @Binding var selectedItem: Item?
    var items: [Item]

    var body: some View {
        HStack(alignment: .center) {
            ForEach(items) { item in
                Spacer()
                VStack {
                    Text(item.label)
                    Image(systemName: item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(selectedItem?.id == item.id ? .blue : .gray)
                }
                .onTapGesture {
                    selectedItem = item
                }
                Spacer()
            }
        }.frame(maxWidth: .infinity)
    }
}

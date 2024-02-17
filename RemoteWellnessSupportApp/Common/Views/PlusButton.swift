//
//  PlusButton.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/12.
//

import SwiftUI

struct PlusButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
        )
        .padding()
    }
}

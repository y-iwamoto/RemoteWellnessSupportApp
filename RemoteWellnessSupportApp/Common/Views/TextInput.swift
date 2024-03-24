//
//  TextInput.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import SwiftUI

struct TextInput: View {
    var labelName: String
    @Binding var value: String
    var body: some View {
        TextField(labelName, text: $value)
            .padding()
            .foregroundColor(.black)
            .padding(10)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

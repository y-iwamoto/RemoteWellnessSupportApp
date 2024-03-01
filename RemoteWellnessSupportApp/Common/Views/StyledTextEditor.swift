//
//  StyledTextEditor.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/21.
//

import SwiftUI

struct StyledTextEditor: View {
    @Binding var value: String
    var placeholder: String
    var numberOfLines: Int = 2
    let textEditorOneLineHeight: CGFloat = 25

    var body: some View {
        ZStack(alignment: .topLeading) {
            if value.isEmpty {
                Text(placeholder)
                    .modifier(CommonStyledModifier())
                    .padding(.vertical, 12)
                    .foregroundColor(Color.gray)
            }
            TextEditor(text: $value)
                .modifier(CommonStyledModifier())
                .padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .frame(height: CGFloat(numberOfLines) * textEditorOneLineHeight)
        .padding(.all)
    }
}

private struct CommonStyledModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
    }
}

#Preview {
    Form {
        StyledTextEditor(value: .constant(""), placeholder: "自由に気持ちを吐き出しましょう")
    }
}

#Preview("3行") {
    Form {
        StyledTextEditor(value: .constant(""), placeholder: "自由に気持ちを吐き出しましょう", numberOfLines: 3)
    }
}

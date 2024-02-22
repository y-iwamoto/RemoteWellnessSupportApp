//
//  StyledTextEditor.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/21.
//

import SwiftUI

struct StyledTextEditor: View {
    @Binding var value: String
    var placefolder: String
    var numberOfLines: Int = 2
    let textEditorOneLineHeight: CGFloat = 25

    var body: some View {
        ZStack(alignment: .topLeading) {
            if value.isEmpty {
                Text(placefolder)
                    .font(.system(size: 18))
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $value)
                .font(.system(size: 18))
                .frame(minHeight: textEditorOneLineHeight)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .frame(height: CGFloat(numberOfLines) * 25)
        .padding(.all)
    }
}

#Preview {
    Form {
        StyledTextEditor(value: .constant(""), placefolder: "自由に気持ちを吐き出しましょう")
    }
}

#Preview("3行") {
    Form {
        StyledTextEditor(value: .constant(""), placefolder: "自由に気持ちを吐き出しましょう", numberOfLines: 3)
    }
}

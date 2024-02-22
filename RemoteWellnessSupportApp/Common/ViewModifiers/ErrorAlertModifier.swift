//
//  ErrorAlertModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/22.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var isErrorAlert: Bool
    @Binding var errorMessage: String

    func body(content: Content) -> some View {
        content
            .alert("エラーです", isPresented: $isErrorAlert) {
                Button("戻る", role: .cancel) {
                    isErrorAlert = false
                }
            } message: {
                Text(errorMessage)
            }
    }
}

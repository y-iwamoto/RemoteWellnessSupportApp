//
//  PomodoroButton.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/21.
//

import SwiftUI

struct PomodoroButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(title) {
            action()
        }
        .padding()
        .background(backgroundColor)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

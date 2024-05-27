//
//  PomodoroReminderView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/14.
//

import SwiftUI

struct PomodoroReminderView: View {
    @StateObject var viewModel = PomodoroReminderViewModel()
    @EnvironmentObject private var router: NotificationSettingNavigationRouter
    var body: some View {
        VStack(spacing: 10) {
            Text("ポモドーロリマインダーについて設定して下さい")
                .font(.title)
                .padding(.top, 10)

            Toggle(isOn: $viewModel.isReminderActive) {
                Text("通知設定の有無")
            }
            .padding()

            Spacer()

            CommonButtonView(title: "次へ進む") {
                if viewModel.savePomodoroReminder() {
                    router.items.append(.notificationSettingEnd)
                }
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 10)
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}

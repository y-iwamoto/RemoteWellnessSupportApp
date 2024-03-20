//
//  NotificationPermissionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/14.
//

import SwiftUI

struct NotificationPermissionView: View {
    @StateObject var viewModel =  NotificationPermissionViewModel()
    @EnvironmentObject var router: NotificationSettingNavigationRouter
    
    var body: some View {
        VStack {
            Text("通知を設定して下さい")
                .font(.title)
            Spacer()
            VStack(spacing: 10) {
                CommonButtonView(title: "次へ進む", disabled: !viewModel.isNotificationPermissionGranted) {
                    router.items.append(.physicalConditionReminder)
                }
                
                NavigationLink(value: NotificationSettingNavigationItem.notificationSettingEnd) {
                    Text("通知設定をスキップする")
                }
            }
        }
        .padding(.vertical, 50)
        .task {
           await viewModel.scheduleNotification()
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}

#Preview {
    NotificationPermissionView()
}

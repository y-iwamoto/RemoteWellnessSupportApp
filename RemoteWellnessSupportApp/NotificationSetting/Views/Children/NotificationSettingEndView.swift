//
//  NotificationSettingEndView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import SwiftUI

struct NotificationSettingEndView: View {
    @StateObject var viewModel = NotificationSettingEndViewModel()

    var body: some View {
        VStack {
            Text("初期設定完了しました")
                .font(.title)
            Spacer()
            VStack(spacing: 20) {
                Text("初期登録が一通り完了しました。")
                Text("次の画面から利用してみましょう。")
            }
            Spacer()
            CommonButtonView(title: "次へ進む") {
                viewModel.endNotificationSettings()
            }
        }
        .padding(30)
    }
}

#Preview {
    NotificationSettingEndView()
}

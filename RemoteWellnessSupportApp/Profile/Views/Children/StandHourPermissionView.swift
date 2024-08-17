//
//  StandHourPermissionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/13.
//

import SwiftUI

struct StandHourPermissionView: View {
    @EnvironmentObject var router: ProfileNavigationRouter
    @StateObject var viewModel = StandHourPermissionViewModel()

    var body: some View {
        CommonLayoutView(
            title: "座りっぱなしかどうかを確認するための設定を行なってください",
            buttonTitle: "次へ進む",
            content: {
                if viewModel.isLoading {
                    ProgressView("ヘルスケアの許可を求めています…")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    Text("許可しないを選択した場合でも、後に設定変更から許可を変更することができます")
                        .font(.body)
                }
            },
            buttonAction: {
                router.items.append(.goalSettingInput)
            },
            isFirstView: false,
            isButtonDisabled: viewModel.isLoading
        )
        .onAppear {
            Task {
                await viewModel.authorizeHealthKit()
            }
        }
    }
}

#Preview {
    StandHourPermissionView()
}

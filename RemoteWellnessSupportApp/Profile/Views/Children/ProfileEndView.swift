//
//  ProfileEndView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/18.
//

import SwiftUI

struct ProfileEndView: View {
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister = Const.AppDefaults.hasCompletedProfileRegister

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
                hasCompletedProfileRegister = true
            }
        }
        .padding(30)
    }
}

#Preview {
    ProfileEndView()
}

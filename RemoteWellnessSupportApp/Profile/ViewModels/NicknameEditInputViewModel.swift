//
//  NicknameEditInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/02.
//

import Foundation

class NicknameEditInputViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    var profile: Profile

    @Published var nickname = ""

    init(dataSource: ProfileDataSource = ProfileDataSource.shared, profile: Profile) {
        self.dataSource = dataSource
        self.profile = profile
        nickname = profile.nickname
    }

    func updateNickname() -> Bool {
        guard inputValidate(nickname: nickname) else {
            setError(withMessage: "ニックネームが未入力です")
            return false
        }
        do {
            profile.nickname = nickname
            try dataSource.updateProfile()
            return true
        } catch {
            setError(withMessage: "ニックネームの更新に失敗しました")
        }
        return false
    }

    private func inputValidate(nickname: String) -> Bool {
        !nickname.isEmpty
    }
}

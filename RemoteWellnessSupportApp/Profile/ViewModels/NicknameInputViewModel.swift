//
//  NicknameInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import Foundation

class NicknameInputViewModel: FormBaseViewModel {
    func inputValidate(nickname: String) -> Bool {
        if nickname == "" {
            setError(withMessage: "ニックネームが未入力です")
            return false
        }
        return true
    }
}

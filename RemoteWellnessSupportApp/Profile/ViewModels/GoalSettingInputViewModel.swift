//
//  GoalSettingInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import Foundation

class GoalSettingInputViewModel: BaseViewModel {
    func inputValidate(goalValue: String) -> Bool {
        guard let number = Int(goalValue) else {
            setError(withMessage: "数値型の文字列を入力して下さい")
            return false
        }

        if number < 0 || number > 10000 {
            setError(withMessage: "0~9999までの数値を入力して下さい")
            return false
        }
        return true
    }

    func extractNumbersFromString(_ newValue: String) -> String {
        newValue.filter { "0123456789".contains($0) }
    }
}

//
//  GoalSettingInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import Foundation

class GoalSettingInputViewModel: FormBaseViewModel {
    func inputValidate(hydrationGoal: String) -> Bool {
        guard let number = Int(hydrationGoal) else {
            setError(withMessage: "数値型の文字列を入力して下さい")
            return false
        }

        if number < 0 || number > 10000 {
            setError(withMessage: "0~9999までの数値を入力して下さい")
            return false
        }
        return true
    }

    func processHydrationGoalChange(_ newValue: String) -> String {
        let filtered = newValue.filter { "0123456789".contains($0) }
        return filtered
    }
}

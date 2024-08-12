//
//  GoalSettingEditInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import Foundation

class GoalSettingEditInputViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    var profile: Profile
    @Published var hydrationGoal: String

    init(dataSource: ProfileDataSource = ProfileDataSource.shared, profile: Profile) {
        self.dataSource = dataSource
        self.profile = profile
        hydrationGoal = profile.hydrationGoal.roundedString
    }

    func updateGoalSettings() -> Bool {
        do {
            guard inputValidate(goalValue: hydrationGoal) else {
                return false
            }
            guard let hydrationGoalDoubleValue = Double(hydrationGoal) else {
                setError(withMessage: "入力値が無効です")
                return false
            }
            profile.hydrationGoal = hydrationGoalDoubleValue

            try dataSource.updateProfile()
            return true
        } catch {
            setError(withMessage: "休憩時間の更新に失敗しました")
        }
        return false
    }

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

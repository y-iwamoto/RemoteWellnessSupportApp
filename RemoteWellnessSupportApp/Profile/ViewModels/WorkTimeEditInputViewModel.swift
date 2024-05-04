//
//  WorkTimeEditInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/03.
//

import Foundation

class WorkTimeEditInputViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    var profile: Profile
    @Published var workTimeFrom: TimeSelection
    @Published var workTimeTo: TimeSelection

    init(dataSource: ProfileDataSource = ProfileDataSource.shared, profile: Profile) {
        self.dataSource = dataSource
        self.profile = profile
        workTimeFrom = TimeSelection(selectedTime: profile.workTimeFrom)
        workTimeTo = TimeSelection(selectedTime: profile.workTimeTo)
    }

    func updateWorkTimes() -> Bool {
        guard inputValidate() else {
            return false
        }
        do {
            profile.workTimeFrom = workTimeFrom.selectedTime
            profile.workTimeTo = workTimeTo.selectedTime
            try dataSource.updateProfile()
            return true
        } catch {
            setError(withMessage: "勤務時間の更新に失敗しました")
        }
        return false
    }

    private func inputValidate() -> Bool {
        if workTimeFrom.selectedTime >= workTimeTo.selectedTime {
            setError(withMessage: "開始時間の方が終了時間より未来時間を指定しています")
            return false
        }
        return true
    }
}

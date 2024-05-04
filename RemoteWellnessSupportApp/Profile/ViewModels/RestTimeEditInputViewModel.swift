//
//  RestTimeEditInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import Foundation

class RestTimeEditInputViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    var profile: Profile
    @Published var restTimePeriodSections: [RestTimePeriodSection]

    init(dataSource: ProfileDataSource = ProfileDataSource.shared, profile: Profile) {
        self.dataSource = dataSource
        self.profile = profile
        restTimePeriodSections = profile.restTimePeriods.map { $0.toSection() }
    }

    func updateRestTimes() -> Bool {
        do {
            guard inputValidate() else {
                return false
            }
            profile.restTimePeriods = restTimePeriodSections.map { $0.toPeriod() }
            try dataSource.updateProfile(profile: profile)
            return true
        } catch {
            setError(withMessage: "休憩時間の更新に失敗しました")
        }
        return false
    }

    private func inputValidate() -> Bool {
        if restTimePeriodSections.isEmpty {
            setError(withMessage: "休憩時間が未設定です")
            return false
        }

        if restTimePeriodSections.contains(where: { $0.fromTime.selectedTime > $0.toTime.selectedTime }) {
            setError(withMessage: "休憩時間の開始時間が終了時間よりも後になっています")
            return false
        }
        return true
    }
}

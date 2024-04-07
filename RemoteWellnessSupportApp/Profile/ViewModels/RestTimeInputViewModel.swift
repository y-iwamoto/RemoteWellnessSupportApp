//
//  RestTimeInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import Foundation

class RestTimeInputViewModel: BaseViewModel {
    func inputValidate(restTimePeriodSections: [RestTimePeriodSection]) -> Bool {
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

//
//  WorkTimeInputViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import Foundation

class WorkTimeInputViewModel: FormBaseViewModel {
    func inputValidate(workTimeFrom: TimeSelection, workTimeTo: TimeSelection) -> Bool {
        if workTimeFrom.selectedTime > workTimeTo.selectedTime {
            setError(withMessage: "開始時間の方が終了時間より未来時間を指定しています")
            return false
        }
        return true
    }
}

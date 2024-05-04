//
//  RestTimePeriodSection+Extensions.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import Foundation

extension RestTimePeriodSection {
    func toPeriod() -> RestTimePeriod {
        let fromTimeDate = fromTime
        let toTimeDate = toTime
        return RestTimePeriod(fromTime: fromTimeDate.selectedTime, toTime: toTimeDate.selectedTime)
    }
}

//
//  RestTimePeriod+Extensions.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import Foundation

extension RestTimePeriod {
    func toSection() -> RestTimePeriodSection {
        let fromTimeSelection = TimeSelection(selectedTime: fromTime)
        let toTimeSelection = TimeSelection(selectedTime: toTime)
        return RestTimePeriodSection(fromTime: fromTimeSelection, toTime: toTimeSelection)
    }
}

//
//  ReminderViewModelProtocol.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/09.
//

import Foundation

protocol ReminderViewModelProtocol: ObservableObject {
    var isReminderActive: Bool { get set }
    var selectedTab: Reminder { get set }
    var selectedHour: Int { get set }
    var selectedMinute: Int { get set }
    var scheduledTimeSelections: [TimeSelection] { get set }
    var isErrorAlert: Bool { get set }
    var errorMessage: String { get set }
}

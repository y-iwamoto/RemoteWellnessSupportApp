//
//  WeekStanHourListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import HealthKit

@MainActor
class WeekStanHourListViewModel: BaseViewModel {
    var manager: HealthKitManager
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    @Published private(set) var standHours: [HKCategorySample] = []
    @Published private(set) var weekDates: [Date] = []

    override init() {
        manager = HealthKitManager()
        super.init()
    }

    func fetchStandHours() async {
        let calendar = Calendar.current
        let nowTime = Date()
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: nowTime)!
        let startOfDayOneWeekAgo = calendar.startOfDay(for: oneWeekAgo)
        weekDates = generateWeekDates(from: startOfDayOneWeekAgo, to: nowTime, calendar: calendar)
    }

    // 7日前から今日までの日付（00:00:00）を生成して返す
    private func generateWeekDates(from startDate: Date, to endDate: Date, calendar: Calendar) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate

        while currentDate <= endDate {
            // currentDate の 23:59:59 を取得
            if let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: currentDate) {
                dates.append(endOfDay)
            }

            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }

        return dates
    }
}

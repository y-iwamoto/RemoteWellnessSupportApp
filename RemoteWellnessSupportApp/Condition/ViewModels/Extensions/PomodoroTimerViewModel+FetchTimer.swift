//
//  PomodoroTimerViewModel+FetchTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func fetchCount() throws -> [Pomodoro] {
        let predicate = try createPredicateForOneDayPomodoro()
        let pomodoros = try dataSource.fetchPomodoros(predicate: predicate)
        let workTimeEndPomodoros = pomodoros.filter {
            $0.activityType == .workTime
        }
        return workTimeEndPomodoros
    }

    private func createPredicateForOneDayPomodoro() throws -> Predicate<Pomodoro> {
        let (startOfDay, endOfDay) = try dayPeriod(for: Date())
        // let workTimeType = PomodoroActivityType.workTime
        let predicate = #Predicate<Pomodoro> { pomodoro in

            pomodoro.registeredAt >= startOfDay && pomodoro.registeredAt < endOfDay
            // TODO: xcodeのバージョンを上げたら直るか確認
            // pomodoro.activityType == workTimeType
        }
        return predicate
    }

    private func dayPeriod(for date: Date) throws -> (startOfDay: Date, endOfDay: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            throw DateError.calculationFailed(description: "Failed to calculate the end of day")
        }
        return (startOfDay, endOfDay)
    }
}

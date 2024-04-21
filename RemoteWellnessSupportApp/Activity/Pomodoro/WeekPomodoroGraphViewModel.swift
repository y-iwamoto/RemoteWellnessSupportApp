//
//  WeekPomodoroGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/19.
//

import Foundation

class WeekPomodoroGraphViewModel: BaseIncrementalYLabelGraphViewModel {
    private var dataSource: PomodoroDataSource

    init(dataSource: PomodoroDataSource = PomodoroDataSource.shared, profileDataSource: ProfileDataSource = .shared) {
        self.dataSource = dataSource
        super.init(profileDataSource: profileDataSource)
    }

    @Published var weekPomodoros: [GraphValue] = []
    @Published var pomodoroRateYGraphRange: ClosedRange<Int> = 0 ... 3
    @Published var pomodoroRatingYGraphValues: [Int] = []

    func fetchPomodoros() {
        do {
            let predicate = try createPredicateForRecentOneWeekPomodoro()
            let pomodoros = try dataSource.fetchPomodoros(predicate: predicate)
            let workTimeEndPomodoros = pomodoros.filter {
                $0.activityType == .workTime
            }
            try assignWeekPomodoros(workTimeEndPomodoros)
        } catch {
            setError(withMessage: "取得処理に失敗しました", error: error)
        }
    }

    private func assignWeekPomodoros(_ pomodoros: [Pomodoro]) throws {
        do {
            if !pomodoros.isEmpty {
                let (dateRange, groupedPomodoros) = try calculateDateRangeAndGroupedPomodoros(pomodoros)
                weekPomodoros = convertToGraphValues(dateRange: dateRange, groupedValues: groupedPomodoros)
                pomodoroRatingYGraphValues = convertToYGraphLabelValues(dateRange: dateRange, groupedGraphValues: groupedPomodoros,
                                                                        initialRatingValues: [0, 1, 2, 3])
                pomodoroRateYGraphRange = convertToPomodoroRateRange()
            }
        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedPomodoros(_ pomodoros: [Pomodoro]) throws -> ([Date], [Date: [Pomodoro]]) {
        do {
            let dateRange = try calculateDateRange()
            let groupedPomodoros = groupValuesByRegisteredAt(pomodoros)
            return (dateRange, groupedPomodoros)
        } catch {
            throw error
        }
    }

    private func createPredicateForRecentOneWeekPomodoro() throws -> Predicate<Pomodoro> {
        let oneWeekAgo = dateOneWeekAgo()
        let workTimeType = PomodoroActivityType.workTime
        let predicate = #Predicate<Pomodoro> { pomodoro in

            pomodoro.registeredAt > oneWeekAgo
            // TODO: xcodeのバージョンを上げたら直るか確認
            // pomodoro.activityType == workTimeType
        }
        return predicate
    }

    func groupValuesByRegisteredAt(_ values: [Pomodoro]) -> [Date: [Pomodoro]] {
        let calendar = Calendar.current
        let groupedValues = Dictionary(grouping: values) { value -> Date in
            calendar.startOfDay(for: value.registeredAt)
        }
        return groupedValues
    }

    func convertToGraphValues(dateRange: [Date], groupedValues: [Date: [Pomodoro]]) -> [GraphValue] {
        let graphValues: [GraphValue] = dateRange.map { date -> GraphValue in
            if let valuesForDay = groupedValues[date] {
                let totalRating = valuesForDay.filter { $0.activityType == .workTime }.count
                return GraphValue(timeZone: date, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: noEntryValueForSpecificTime)
            }
        }

        return graphValues
    }

    func convertToYGraphLabelValues(dateRange: [Date], groupedGraphValues: [Date: [Pomodoro]], initialRatingValues: [Int]) -> [Int] {
        let totalRatings = dateRange.compactMap { date -> Int? in
            if let graphValuesForDay = groupedGraphValues[date] {
                let totalRating = graphValuesForDay.filter { $0.activityType == .workTime }.count
                return totalRating
            } else {
                return nil
            }
        }
        guard let maxRating = totalRatings.max(), maxRating != noEntryValueForSpecificTime else {
            return initialRatingValues
        }
        // TODO: ここは動作確認する
        if maxRating < 3 {
            return [0, 1, 2, 3].map { $0 * 3 / 3 }
        }
        return [0, 1, 2, 3].map { $0 * maxRating / 3 }
    }

    private func convertToPomodoroRateRange() -> ClosedRange<Int> {
        let pomodoroRatingMax = pomodoroRatingYGraphValues.max() ?? 3
        return noEntryValueForSpecificTime ... pomodoroRatingMax
    }
}

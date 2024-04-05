//
//  HydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation

class HydrationGraphViewModel: FormBaseViewModel {
    private let dataSource: HydrationDataSource
    private let noEntryValueForSpecificTime = 0
    private let targetDate: Date

    init(dataSource: HydrationDataSource = .shared, targetDate: Date = Date()) {
        self.dataSource = dataSource
        self.targetDate = targetDate
    }

    @Published var todayHydrations: [GraphValue] = []
    @Published var hydrationRateYGraphRange: ClosedRange<Int> = 0 ... HydrationRating.mugCup.rawValue
    @Published var hydrationRatingYGraphValues: [Int] = []

    func fetchHydrations() {
        do {
            let predicate = createPredicateForLastDay()
            let hydrations = try dataSource.fetchHydration(predicate: predicate)
            assignTodayHydrations(hydrations)
        } catch {
            setError(withMessage: "水分データの取得に失敗しました")
        }
    }

    private func assignTodayHydrations(_ hydrations: [Hydration]) {
        if !hydrations.isEmpty {
            let (hoursRange, groupedHydrations) = calculateDateRangeAndGroupedHydrations(hydrations)
            todayHydrations = convertToGraphHydrations(hourRange: hoursRange, groupedHydrations: groupedHydrations)
            hydrationRatingYGraphValues = convertToHydrationYGraphLabelValues(hourRange: hoursRange, groupedHydrations: groupedHydrations)
            hydrationRateYGraphRange = convertToHydrationRateRange()
        }
    }

    private func calculateDateRangeAndGroupedHydrations(_ hydrations: [Hydration]) -> ([Date], [Date: [Hydration]]) {
        let calendar = Calendar.current
        let currentDate = Date()
        let currentHour = calendar.component(.hour, from: targetDate)
        // TODO: 現在はhoursRangeを特定値で固定にしているが別途、ここも動的になる
        let startHour = 0
        let endHour = 9
        let defaultEndHour = 19
        let hoursRange: Range<Int> = (currentHour > startHour && currentHour < endHour) ? startHour ..< currentHour + 1 : endHour ..< defaultEndHour

        let dates = hoursRange.compactMap { hour -> Date? in
            calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate)
        }

        let groupedHydrations = Dictionary(grouping: hydrations) { hydration -> Date in
            let hour = calendar.component(.hour, from: hydration.entryDate)
            let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate) ?? currentDate
            return date
        }

        let conditionsInHour = dates.reduce(into: [Date: [Hydration]]()) { result, date in
            result[date] = groupedHydrations[date] ?? []
        }

        return (dates, conditionsInHour)
    }

    private func convertToGraphHydrations(hourRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [GraphValue] {
        let graphHydrations: [GraphValue] = hourRange.map { hour -> GraphValue in
            if let hydrationsForDay = groupedHydrations[hour] {
                let totalRating = hydrationsForDay.reduce(0) { $0 + $1.rating }
                return GraphValue(timeZone: hour, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: hour, rateAverage: 0)
            }
        }

        return graphHydrations
    }

    private func convertToHydrationYGraphLabelValues(hourRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [Int] {
        let totalRatings = hourRange.compactMap { date -> Int? in
            if let hydrationsForDay = groupedHydrations[date] {
                let totalRating = hydrationsForDay.reduce(0) { $0 + $1.rating }
                return totalRating
            } else {
                return nil
            }
        }
        guard let maxRating = totalRatings.max(), maxRating != 0 else {
            return HydrationRating.initialHydrationRatingValues
        }

        return [0, 1, 2, 3].map { $0 * maxRating / 3 }
    }

    private func convertToHydrationRateRange() -> ClosedRange<Int> {
        let hydrationRatingMax = hydrationRatingYGraphValues.max() ?? HydrationRating.mugCup.rawValue
        return 0 ... hydrationRatingMax
    }

    private func createPredicateForLastDay() -> Predicate<Hydration> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: targetDate)
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            fatalError("Failed to calculate the end of day")
        }
        let predicate = #Predicate<Hydration> { hydration in
            hydration.entryDate >= startOfDay && hydration.entryDate < endOfDay
        }
        return predicate
    }
}

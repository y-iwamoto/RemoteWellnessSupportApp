//
//  HydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation

class HydrationGraphViewModel: BaseSelectedDateGraphViewModel {
    private let hydrationDataSource: HydrationDataSource

    init(hydrationDataSource: HydrationDataSource = .shared,
         profileDataSource: ProfileDataSource = .shared,
         targetDate: Date = Date()) {
        self.hydrationDataSource = hydrationDataSource
        super.init(profileDataSource: profileDataSource, targetDate: targetDate)
    }

    @Published var targetDateHydrations: [GraphValue] = []
    @Published var hydrationRateYGraphRange: ClosedRange<Int> = 0 ... HydrationRating.mugCup.rawValue
    @Published var hydrationRatingYGraphValues: [Int] = []

    func fetchHydrations() {
        do {
            let predicate = createPredicateForLastDay()
            let hydrations = try hydrationDataSource.fetchHydration(predicate: predicate)
            try assignTargetDateHydrations(hydrations)
        } catch {
            setError(withMessage: "水分データの取得に失敗しました", error: error)
        }
    }

    private func assignTargetDateHydrations(_ hydrations: [Hydration]) throws {
        do {
            if !hydrations.isEmpty {
                let (hoursRange, groupedHydrations) = try calculateDateRangeAndGroupedHydrations(hydrations)
                targetDateHydrations = convertToGraphHydrations(hourRange: hoursRange, groupedHydrations: groupedHydrations)
                hydrationRatingYGraphValues = convertToHydrationYGraphLabelValues(hourRange: hoursRange, groupedHydrations: groupedHydrations)
                hydrationRateYGraphRange = convertToHydrationRateRange()
            }

        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedHydrations(_ hydrations: [Hydration]) throws -> ([Date], [Date: [Hydration]]) {
        let calendar = Calendar.current
        do {
            let hoursRange = try calculateWorkHoursRange()

            let currentDate = Date()
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

        } catch {
            throw error
        }
    }

    private func convertToGraphHydrations(hourRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [GraphValue] {
        let graphHydrations: [GraphValue] = hourRange.map { hour -> GraphValue in
            if let hydrationsForDay = groupedHydrations[hour] {
                let totalRating = hydrationsForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
                return GraphValue(timeZone: hour, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: hour, rateAverage: noEntryValueForSpecificTime)
            }
        }

        return graphHydrations
    }

    private func convertToHydrationYGraphLabelValues(hourRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [Int] {
        let totalRatings = hourRange.compactMap { date -> Int? in
            if let hydrationsForDay = groupedHydrations[date] {
                let totalRating = hydrationsForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
                return totalRating
            } else {
                return nil
            }
        }
        guard let maxRating = totalRatings.max(), maxRating != noEntryValueForSpecificTime else {
            return HydrationRating.initialHydrationRatingValues
        }

        return [0, 1, 2, 3].map { $0 * maxRating / 3 }
    }

    private func convertToHydrationRateRange() -> ClosedRange<Int> {
        let hydrationRatingMax = hydrationRatingYGraphValues.max() ?? HydrationRating.mugCup.rawValue
        return noEntryValueForSpecificTime ... hydrationRatingMax
    }

    private func createPredicateForLastDay() -> Predicate<Hydration> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: targetDate)
        let endOfDayComponents = DateComponents(day: 1)
        let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay)!
        let predicate = #Predicate<Hydration> { hydration in
            hydration.entryDate >= startOfDay && hydration.entryDate < endOfDay
        }
        return predicate
    }
}

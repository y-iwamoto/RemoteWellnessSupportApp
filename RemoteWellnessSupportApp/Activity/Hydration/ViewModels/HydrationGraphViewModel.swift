//
//  HydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation

class HydrationGraphViewModel: BaseIncrementalYLabelGraphViewModel {
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
            let predicate = try createPredicateForLastDay()
            let hydrations = try hydrationDataSource.fetchHydration(predicate: predicate)
            try assignTargetDateHydrations(hydrations)
        } catch {
            setError(withMessage: "水分データの取得に失敗しました", error: error)
        }
    }

    private func assignTargetDateHydrations(_ hydrations: [Hydration]) throws {
        if !hydrations.isEmpty {
            let (hoursRange, groupedHydrations) = try calculateDateRangeAndGroupedHydrations(hydrations)
            targetDateHydrations = convertToGraphValues(dateRange: hoursRange, groupedValues: groupedHydrations)
            hydrationRatingYGraphValues = convertToYGraphLabelValues(dateRange: hoursRange, groupedGraphValues: groupedHydrations,
                                                                     initialRatingValues: HydrationRating.initialHydrationRatingValues)
            hydrationRateYGraphRange = convertToHydrationRateRange()
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

    private func convertToHydrationRateRange() -> ClosedRange<Int> {
        let hydrationRatingMax = hydrationRatingYGraphValues.max() ?? HydrationRating.mugCup.rawValue
        return noEntryValueForSpecificTime ... hydrationRatingMax
    }

    private func createPredicateForLastDay() throws -> Predicate<Hydration> {
        do {
            let (startOfDay, endOfDay) = try dayPeriod(for: targetDate)
            let predicate = #Predicate<Hydration> { hydration in
                hydration.entryDate >= startOfDay && hydration.entryDate < endOfDay
            }
            return predicate
        } catch {
            throw error
        }
    }
}

//
//  WeekHydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/28.
//

import Foundation

class WeekHydrationGraphViewModel: BaseSelectedDateGraphViewModel {
    private let hydrationDataSource: HydrationDataSource

    init(hydrationDataSource: HydrationDataSource = .shared,
         profileDataSource: ProfileDataSource = .shared) {
        self.hydrationDataSource = hydrationDataSource
        super.init(profileDataSource: profileDataSource)
    }

    @Published var weekHydrations: [GraphValue] = []
    @Published var hydrationRateYGraphRange: ClosedRange<Int> = 0 ... HydrationRating.mugCup.rawValue
    @Published var hydrationRatingYGraphValues: [Int] = []

    func fetchWeekHydrations() {
        do {
            let predicate = createPredicateForRecentOneWeekHydrations()
            let hydrations = try hydrationDataSource.fetchHydration(predicate: predicate)
            try assignWeekHydrations(hydrations)
        } catch {
            setError(withMessage: "水分摂取データの取得に失敗しました", error: error)
        }
    }

    private func assignWeekHydrations(_ hydrations: [Hydration]) throws {
        do {
            if !hydrations.isEmpty {
                let (dateRange, groupedHydrations) = try calculateDateRangeAndGroupedHydrations(hydrations)
                weekHydrations = convertToGraphWeekHydrations(dateRange: dateRange, groupedHydrations: groupedHydrations)
                hydrationRatingYGraphValues = convertToHydrationYGraphLabelValues(dateRange: dateRange, groupedHydrations: groupedHydrations)
                hydrationRateYGraphRange = convertToHydrationRateRange()
            }
        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedHydrations(_ hydrations: [Hydration]) throws -> ([Date], [Date: [Hydration]]) {
        let calendar = Calendar.current
        do {
            let dateRange = try calculateDateRange()
            let groupedHydrations = Dictionary(grouping: hydrations) { hydration -> Date in
                calendar.startOfDay(for: hydration.entryDate)
            }

            return (dateRange, groupedHydrations)
        } catch {
            throw error
        }
    }

    private func convertToGraphWeekHydrations(dateRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [GraphValue] {
        let graphHydrations: [GraphValue] = dateRange.map { date -> GraphValue in
            if let hydrationsForDay = groupedHydrations[date] {
                let totalRating = hydrationsForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
                return GraphValue(timeZone: date, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: noEntryValueForSpecificTime)
            }
        }

        return graphHydrations
    }

    private func convertToHydrationYGraphLabelValues(dateRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [Int] {
        let totalRatings = dateRange.compactMap { date -> Int? in
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

    private func createPredicateForRecentOneWeekHydrations() -> Predicate<Hydration> {
        let oneWeekAgo = dateOneWeekAgo()
        let predicate = #Predicate<Hydration> { hydration in
            hydration.entryDate > oneWeekAgo
        }
        return predicate
    }
}

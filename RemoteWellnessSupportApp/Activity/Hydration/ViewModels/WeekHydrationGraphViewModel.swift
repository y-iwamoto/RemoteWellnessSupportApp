//
//  WeekHydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/28.
//

import Foundation

class WeekHydrationGraphViewModel: BaseIncrementalYLabelGraphViewModel {
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
                weekHydrations = convertToGraphValues(dateRange: dateRange, groupedHydrations: groupedHydrations)
                hydrationRatingYGraphValues = convertToYGraphLabelValues(dateRange: dateRange, groupedGraphValues: groupedHydrations,
                                                                         initialRatingValues: HydrationRating.initialHydrationRatingValues)
                hydrationRateYGraphRange = convertToHydrationRateRange()
            }
        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedHydrations(_ hydrations: [Hydration]) throws -> ([Date], [Date: [Hydration]]) {
        do {
            let dateRange = try calculateDateRange()
            let groupedHydrations = groupValuesByEntryDate(hydrations)
            return (dateRange, groupedHydrations)
        } catch {
            throw error
        }
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

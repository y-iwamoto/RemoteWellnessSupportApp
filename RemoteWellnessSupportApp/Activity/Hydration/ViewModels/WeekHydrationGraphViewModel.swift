//
//  WeekHydrationGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/28.
//

import Foundation

class WeekHydrationGraphViewModel: FormBaseViewModel {
    private let dataSource: HydrationDataSource

    init(dataSource: HydrationDataSource = .shared) {
        self.dataSource = dataSource
    }

    @Published var weekHydrations: [GraphValue] = []
    @Published var hydrationRateYGraphRange: ClosedRange<Int> = 0 ... HydrationRating.mugCup.rawValue
    @Published var hydrationRatingYGraphValues: [Int] = []

    func fetchWeekHydrations() {
        do {
            let predicate = createPredicateForRecentOneWeekHydrations()
            let hydrations = try dataSource.fetchHydration(predicate: predicate)
            assignWeekHydrations(hydrations)
        } catch {
            setError(withMessage: "水分摂取データの取得に失敗しました")
        }
    }

    private func assignWeekHydrations(_ hydrations: [Hydration]) {
        if !hydrations.isEmpty {
            let (dateRange, groupedHydrations) = calculateDateRangeAndGroupedHydrations(hydrations)
            weekHydrations = convertToGraphWeekHydrations(dateRange: dateRange, groupedHydrations: groupedHydrations)
            hydrationRatingYGraphValues = convertToHydrationYGraphLabelValues(dateRange: dateRange, groupedHydrations: groupedHydrations)
            hydrationRateYGraphRange = convertToHydrationRateRange()
        }
    }

    private func calculateDateRangeAndGroupedHydrations(_ hydrations: [Hydration]) -> ([Date], [Date: [Hydration]]) {
        let calendar = Calendar.current
        let currentTime = Date()
        let dateRange = (0 ... 6).map { date -> Date in
            let startOfDay = calendar.date(byAdding: .day, value: -date, to: currentTime)!
            return calendar.startOfDay(for: startOfDay)
        }

        let groupedHydrations = Dictionary(grouping: hydrations) { hydration -> Date in
            calendar.startOfDay(for: hydration.entryDate)
        }

        return (dateRange, groupedHydrations)
    }

    private func convertToGraphWeekHydrations(dateRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [GraphValue] {
        let graphHydrations: [GraphValue] = dateRange.map { date -> GraphValue in
            if let hydrationsForDay = groupedHydrations[date] {
                let totalRating = hydrationsForDay.reduce(0) { $0 + $1.rating }
                return GraphValue(timeZone: date, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: 0)
            }
        }

        return graphHydrations
    }

    private func convertToHydrationYGraphLabelValues(dateRange: [Date], groupedHydrations: [Date: [Hydration]]) -> [Int] {
        let totalRatings = dateRange.compactMap { date -> Int? in
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

    private func createPredicateForRecentOneWeekHydrations() -> Predicate<Hydration> {
        let currentTime = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentTime)
        let predicate = #Predicate<Hydration> { hydration in
            hydration.entryDate > (oneWeekAgo ?? currentTime)
        }
        return predicate
    }
}

//
//  BaseIncrementalYLabelGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/07.
//

import Foundation

class BaseIncrementalYLabelGraphViewModel: BaseGraphViewModel {
    func convertToGraphValues(dateRange: [Date], groupedHydrations: [Date: [some GraphColumnHaving]]) -> [GraphValue] {
        let graphValues: [GraphValue] = dateRange.map { date -> GraphValue in
            if let hydrationsForDay = groupedHydrations[date] {
                let totalRating = hydrationsForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
                return GraphValue(timeZone: date, rateAverage: totalRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: noEntryValueForSpecificTime)
            }
        }

        return graphValues
    }

    func convertToYGraphLabelValues(dateRange: [Date], groupedGraphValues: [Date: [some GraphColumnHaving]], initialRatingValues: [Int]) -> [Int] {
        let totalRatings = dateRange.compactMap { date -> Int? in
            if let graphValuesForDay = groupedGraphValues[date] {
                let totalRating = graphValuesForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
                return totalRating
            } else {
                return nil
            }
        }
        guard let maxRating = totalRatings.max(), maxRating != noEntryValueForSpecificTime else {
            return initialRatingValues
        }

        return [0, 1, 2, 3].map { $0 * maxRating / 3 }
    }
}

//
//  WeekHydrationListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/29.
//

import Foundation

class WeekHydrationListViewModel: BaseViewModel {
    private var dataSource: HydrationDataSource
    @Published var dateWithHydrations: [DateWithListValue] = []

    init(dataSource: HydrationDataSource = .shared) {
        self.dataSource = dataSource
    }

    func fetchDateWithHydration() {
        do {
            let predicate = createPredicateForRecentOneWeekHydrations()
            let hydrations = try dataSource.fetchHydration(predicate: predicate)
            assignWeekListItems(hydrations)
        } catch {
            setError(withMessage: "水分摂取データの取得に失敗しました")
        }
    }

    private func createPredicateForRecentOneWeekHydrations() -> Predicate<Hydration> {
        let currentTime = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentTime)
        let predicate = #Predicate<Hydration> { item in
            item.entryDate > oneWeekAgo!
        }
        return predicate
    }

    private func assignWeekListItems(_ listItem: [Hydration]) {
        if listItem.isEmpty {
            dateWithHydrations = []
        } else {
            dateWithHydrations = convertToDateWithListItems(listItem)
        }
    }

    private func convertToDateWithListItems(_ conditions: [Hydration]) -> [DateWithListValue] {
        let calendar = Calendar.current
        let groupedConditions = Dictionary(grouping: conditions) { condition -> Date in
            calendar.startOfDay(for: condition.entryDate)
        }

        let sortedDates = groupedConditions.keys.sorted()

        let dateWithListItems: [DateWithListValue] = sortedDates.map { date -> DateWithListValue in
            DateWithListValue(date: date)
        }

        return dateWithListItems
    }
}

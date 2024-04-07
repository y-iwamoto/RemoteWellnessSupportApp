//
//  DailyHydrationListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/27.
//

import Foundation

class DailyHydrationListViewModel: BaseViewModel {
    private let dataSource: HydrationDataSource
    let targetDate: Date
    @Published var hydrations: [Hydration] = []

    init(dataSource: HydrationDataSource = .shared, targetDate: Date = Date()) {
        self.dataSource = dataSource
        self.targetDate = targetDate
    }

    func fetchHydrations() {
        do {
            let predicate = createPredicateForTargetDate()
            let sortBy = [SortDescriptor(\Hydration.entryDate)]
            hydrations = try dataSource.fetchHydration(predicate: predicate, sortBy: sortBy)
        } catch {
            setError(withMessage: "水分摂取データの取得に失敗しました")
        }
    }

    func deleteHydration(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        do {
            try dataSource.removeHydration(hydrations[index])
        } catch {
            setError(withMessage: "水分摂取データの削除に失敗しました")
        }
    }

    private func createPredicateForTargetDate() -> Predicate<Hydration> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: targetDate)
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            fatalError("Failed to calculate the end of day")
        }
        let predicate = #Predicate<Hydration> { physicalCondition in
            physicalCondition.entryDate >= startOfDay && physicalCondition.entryDate < endOfDay
        }
        return predicate
    }
}

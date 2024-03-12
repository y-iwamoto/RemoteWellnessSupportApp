//
//  DailyPhysicalConditionListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/03.
//

import Foundation

class DailyPhysicalConditionListViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    private let targetDate: Date
    @Published var physicalConditions: [PhysicalCondition] = []
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared, targetDate: Date = Date()) {
        self.dataSource = dataSource
        self.targetDate = targetDate
    }

    func fetchPhysicalConditions() {
        do {
            let predicate = createPredicateForTargetDate()
            let sortBy = [SortDescriptor(\PhysicalCondition.entryDate)]
            physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate, sortBy: sortBy)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    func deletePhysicalCondition(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        do {
            try dataSource.removePhysicalCondition(physicalConditions[index])
        } catch {
            setError(withMessage: "体調データの削除に失敗しました")
        }
    }

    private func createPredicateForTargetDate() -> Predicate<PhysicalCondition> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: targetDate)
        let endOfDayComponents = DateComponents(day: 1)
        let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay)!
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate >= startOfDay && physicalCondition.entryDate < endOfDay
        }
        return predicate
    }

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}

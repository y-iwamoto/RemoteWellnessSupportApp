//
//  TodaysPhysicalConditionListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/03.
//

import Foundation

class TodaysPhysicalConditionListViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    @Published var physicalConditions: [PhysicalCondition] = []
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
    }

    func fetchPhysicalConditions() {
        do {
            let predicate = createPredicateForToday()
            let sortBy = [SortDescriptor(\PhysicalCondition.entryDate)]
            physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate, sortBy: sortBy)
        } catch {
            print("fetch PhysicalCondition Error: \(error)")
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    func deletePhysicalCondition(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        do {
            try dataSource.removePhysicalCondition(physicalConditions[index])
        } catch {
            print("delete PhysicalCondition Error: \(error)")
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func createPredicateForToday() -> Predicate<PhysicalCondition> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate >= startOfDay
        }
        return predicate
    }

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}

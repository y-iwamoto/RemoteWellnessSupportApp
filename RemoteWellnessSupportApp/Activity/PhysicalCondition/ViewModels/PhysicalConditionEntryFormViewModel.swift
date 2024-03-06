//
//  PhysicalConditionEntryFormViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/17.
//

import Foundation

@MainActor
class PhysicalConditionEntryFormViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource

    init(dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
    }

    @Published var selectedDateTime = Date()
    @Published var memo = ""
    @Published var selectedRating: PhysicalConditionRating?
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    func insertPhysicalCondition() -> Bool {
        guard validateInputs() else {
            return false
        }

        guard let rating = selectedRating?.rawValue else { return false }

        let physicalCondition = PhysicalCondition(memo: memo, rating: rating, entryDate: selectedDateTime)

        do {
            try dataSource.insertPhysicalCondition(physicalCondition: physicalCondition)
            return true
        } catch {
            print("register PhysicalCondition Error: \(error)")
            setError(withMessage: "体調登録に失敗しました")
            return false
        }
    }

    private func validateInputs() -> Bool {
        guard (selectedRating?.rawValue) != nil else {
            setError(withMessage: "頭痛の痛みの度合いを選択してください")
            return false
        }

        guard selectedDateTime <= Date() else {
            setError(withMessage: "日付で未来の時間を設定することはできません")
            return false
        }

        return true
    }

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}

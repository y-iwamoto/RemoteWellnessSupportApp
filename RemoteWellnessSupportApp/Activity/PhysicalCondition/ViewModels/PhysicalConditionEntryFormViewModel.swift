//
//  PhysicalConditionEntryFormViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/17.
//

import Foundation

class PhysicalConditionEntryFormViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    private let action: FormAction
    private let physicalCondition: PhysicalCondition?

    init(formAction: FormAction = .create, physicalCondition: PhysicalCondition? = nil, dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
        action = formAction
        self.physicalCondition = physicalCondition

        setFormInitialValue()
    }

    @Published var selectedDateTime = Date()
    @Published var memo = ""
    @Published var selectedRating: PhysicalConditionRating?
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    func formAction() -> Bool {
        switch action {
        case .create:
            insertPhysicalCondition()
        case .update:
            updatePhysicalCondition()
        }
    }

    func updatePhysicalCondition() -> Bool {
        guard validateInputs() else {
            return false
        }
        guard let updatedPhysicalCondition = updatePhysicalConditionValues() else {
            setError(withMessage: "体調更新に失敗しました")
            return false
        }

        do {
            try dataSource.updatePhysicalCondition(physicalCondition: updatedPhysicalCondition)
            return true
        } catch {
            print("update PhysicalCondition Error: \(error)")
            setError(withMessage: "体調更新に失敗しました")
            return false
        }
    }

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

    private func setFormInitialValue() {
        guard let item = physicalCondition else {
            return
        }

        selectedDateTime = item.entryDate
        memo = item.memo
        selectedRating = PhysicalConditionRating(rawValue: item.rating)
    }

    private func updatePhysicalConditionValues() -> PhysicalCondition? {
        guard let physicalCondition else {
            return nil
        }

        guard let rating = selectedRating?.rawValue else { return nil }

        physicalCondition.memo = memo
        physicalCondition.rating = rating
        physicalCondition.entryDate = selectedDateTime

        return physicalCondition
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

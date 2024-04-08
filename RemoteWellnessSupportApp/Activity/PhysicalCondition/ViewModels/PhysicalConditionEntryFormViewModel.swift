//
//  PhysicalConditionEntryFormViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/17.
//

import Foundation

@MainActor
class PhysicalConditionEntryFormViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSourceProtocol
    private let action: FormAction
    private let physicalCondition: PhysicalCondition?
    let targetDate: Date

    init(formAction: FormAction = .create, physicalCondition: PhysicalCondition? = nil,
         dataSource: PhysicalConditionDataSourceProtocol = PhysicalConditionDataSource.shared, targetDate: Date = Date()) {
        self.dataSource = dataSource
        action = formAction
        self.physicalCondition = physicalCondition
        self.targetDate = targetDate

        setFormInitialValue()
    }

    @Published var selectedDateTime = Date()
    @Published var memo = ""
    @Published var selectedRating: PhysicalConditionRating?
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    @Published var isFormSubmitted = false

    func formAction() {
        guard validateInputs() else {
            return
        }

        switch action {
        case .create:
            insertPhysicalCondition()
        case .update:
            updatePhysicalCondition()
        }
    }

    func insertPhysicalCondition() {
        guard let rating = selectedRating?.rawValue else {
            setError(withMessage: "評価を選択してください")
            return
        }

        let physicalCondition = PhysicalCondition(memo: memo, rating: rating, entryDate: selectedDateTime)
        performDataSourceOperation { try self.dataSource.insertPhysicalCondition(physicalCondition: physicalCondition) }
    }

    func updatePhysicalCondition() {
        guard let physicalCondition else {
            setError(withMessage: "更新する体調情報が存在しません")
            return
        }

        guard let rating = selectedRating?.rawValue else {
            setError(withMessage: "評価が選択されていません")
            return
        }

        physicalCondition.memo = memo
        physicalCondition.rating = rating
        physicalCondition.entryDate = selectedDateTime

        performDataSourceOperation { try self.dataSource.updatePhysicalCondition(physicalCondition: physicalCondition) }
    }

    private func performDataSourceOperation(_ operation: () throws -> Void) {
        do {
            try operation()
            isFormSubmitted = true
        } catch {
            setError(withMessage: "データの保存に失敗しました")
        }
    }

    private func setFormInitialValue() {
        guard let item = physicalCondition else {
            selectedDateTime = targetDate
            return
        }
        selectedDateTime = item.entryDate
        memo = item.memo
        selectedRating = PhysicalConditionRating(rawValue: item.rating)
    }

    private func validateInputs() -> Bool {
        guard selectedRating != nil else {
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

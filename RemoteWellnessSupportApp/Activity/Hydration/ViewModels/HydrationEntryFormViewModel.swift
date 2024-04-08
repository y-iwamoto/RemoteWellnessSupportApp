//
//  HydrationEntryFormViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation

class HydrationEntryFormViewModel: BaseViewModel {
    private let dataSource: HydrationDataSource
    private let action: FormAction
    private let hydration: Hydration?
    let targetDate: Date

    init(dataSource: HydrationDataSource = HydrationDataSource.shared, action: FormAction = .create,
         hydration: Hydration? = nil, targetDate: Date = Date()) {
        self.dataSource = dataSource
        self.action = action
        self.hydration = hydration
        self.targetDate = targetDate

        super.init()
        setFormInitialValue()
    }

    @Published var selectedDateTime = Date()
    @Published var selectedRating: HydrationRating?
    @Published var isFormSubmitted = false

    func formAction() {
        guard validateInputs() else {
            return
        }

        switch action {
        case .create:
            insertHydration()
        case .update:
            updateHydration()
        }
    }

    func insertHydration() {
        guard let rating = selectedRating?.rawValue else {
            setError(withMessage: "水分摂取量を選択してください")
            return
        }

        let hydration = Hydration(rating: rating, entryDate: selectedDateTime)
        performDataSourceOperation { try self.dataSource.insertHydration(hydration: hydration) }
    }

    func updateHydration() {
        guard let hydration else {
            setError(withMessage: "更新する水分摂取情報が存在しません")
            return
        }

        guard let rating = selectedRating?.rawValue else {
            setError(withMessage: "水分摂取量が選択されていません")
            return
        }

        hydration.rating = rating
        hydration.entryDate = selectedDateTime

        performDataSourceOperation { try self.dataSource.updateHydration(hydration) }
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
        guard let item = hydration else {
            selectedDateTime = targetDate
            return
        }
        selectedDateTime = item.entryDate
        selectedRating = HydrationRating(rawValue: item.rating)
    }

    private func validateInputs() -> Bool {
        guard selectedRating != nil else {
            setError(withMessage: "水分摂取量を選択してください")
            return false
        }

        guard selectedDateTime <= Date() else {
            setError(withMessage: "日付で未来の時間を設定することはできません")
            return false
        }

        return true
    }
}

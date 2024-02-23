//
//  PhysicalConditionEntryFormViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/17.
//

import Combine
import Foundation
import SwiftData

class PhysicalConditionEntryFormViewModel: ObservableObject {
    @Published var selectedDateTime = Date()
    @Published var memo = ""
    @Published var selectedRating: PhysicalConditionRating?
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    let successPublisher = PassthroughSubject<Void, Never>()

    func insertPhysicalCondition(_ modelContext: ModelContext) {
        guard validateInputs() else {
            return
        }

        guard let rating = selectedRating?.rawValue else { return }

        let physicalCondition = PhysicalCondition(memo: memo, rating: rating, entryDate: selectedDateTime, createdAt: Date(), updatedAt: Date())

        do {
            modelContext.insert(physicalCondition)
            try modelContext.save()
            successPublisher.send()
        } catch {
            print("register PhysicalCondition Error: \(error)")
            setError(withMessage: "体調登録に失敗しました")
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
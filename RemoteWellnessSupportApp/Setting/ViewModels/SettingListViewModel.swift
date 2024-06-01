//
//  SettingListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import Foundation

class SettingListViewModel: BaseViewModel {
    private let dataSource: DataDeletionDataSource
    @Published var showModal = false

    init(dataSource: DataDeletionDataSource = DataDeletionDataSource.shared) {
        self.dataSource = dataSource
    }

    func unsubscribe() {
        do {
            try dataSource.deleteAllData()
        } catch {
            setError(withMessage: "データ削除に失敗しました。時間をおいてもう一度再実行してください。", error: error)
        }
    }
}

//
//  StandHourPermissionViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/14.
//

import Foundation
import HealthKit

@MainActor
final class StandHourPermissionViewModel: BaseViewModel {
    var manager: HealthKitManager
    let standHourType = HKObjectType.categoryType(forIdentifier: .appleStandHour)!
    @Published var isDoneAuthorizeRequest = false
    @Published var isLoading = false

    override init() {
        manager = HealthKitManager()
        super.init()
    }

    func authorizeHealthKit() async {
        isLoading = true
        do {
            try await manager.authorizeHealthKit(toShare: [], read: [standHourType])
            isDoneAuthorizeRequest = true
            isLoading = false
        } catch {
            setError(withMessage: "ヘルスケアの認証処理に失敗しました", error: error)
        }
    }
}

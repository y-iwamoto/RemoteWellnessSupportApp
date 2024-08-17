//
//  ProfileSettingViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/30.
//

import Foundation

class ProfileSettingViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    @Published var profileRecord: Profile?
    @Published var isOpenAlert = false

    var workDaysLabels: String {
        guard let profile = profileRecord else {
            return ""
        }
        return profile.workDays.map(\.labelName).joined(separator: ", ")
    }

    init(dataSource: ProfileDataSource = ProfileDataSource.shared) {
        self.dataSource = dataSource
        super.init()
        fetchProfile()
    }

    func fetchProfile() {
        do {
            guard let profile = try dataSource.fetchProfile() else {
                return
            }
            profileRecord = profile
        } catch {
            setError(withMessage: "プロファイル情報の取得に失敗しました")
        }
    }
}

//
//  ProfileDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/21.
//

import Foundation
import SwiftData

final class ProfileDataSource {
    private let manager = ModelManager.shared
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ProfileDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertProfile(profile: Profile) throws {
        modelContext.insert(profile)
        try modelContext.save()
    }

    func fetchProfile() throws -> Profile? {
        let descriptor = FetchDescriptor<Profile>()
        return try modelContext.fetch(descriptor).first ?? nil
    }

    func updateProfile() throws {
        try modelContext.save()
    }
}

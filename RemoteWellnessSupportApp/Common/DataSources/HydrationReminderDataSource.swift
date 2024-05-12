//
//  HydrationReminderDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation
import SwiftData

final class HydrationReminderDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    private let manager = ModelManager.shared

    @MainActor
    static let shared = HydrationReminderDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertHydrationReminder(hydrationReminder: HydrationReminder) throws {
        modelContext.insert(hydrationReminder)
        try modelContext.save()
    }

    func fetchHydrationReminder() throws -> HydrationReminder? {
        let descriptor = FetchDescriptor<HydrationReminder>()
        return try modelContext.fetch(descriptor).last
    }

    func updateHydrationReminder() throws {
        try modelContext.save()
    }
}

//
//  PhysicalConditionReminderDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation
import SwiftData

final class PhysicalConditionReminderDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    private let manager = ModelManager.shared

    @MainActor
    static let shared = PhysicalConditionReminderDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertPhysicalConditionReminder(physicalConditionReminder: PhysicalConditionReminder) throws {
        modelContext.insert(physicalConditionReminder)
        try modelContext.save()
    }

    func fetchPhysicalConditionReminder() throws -> PhysicalConditionReminder? {
        let descriptor = FetchDescriptor<PhysicalConditionReminder>()
        return try modelContext.fetch(descriptor).last
    }

    func updatePhysicalConditionReminder() throws {
        try modelContext.save()
    }
}

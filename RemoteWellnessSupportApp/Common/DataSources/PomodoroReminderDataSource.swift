//
//  PomodoroReminderDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/14.
//

import Foundation
import SwiftData

final class PomodoroReminderDataSource {
    private let manager = ModelManager.shared
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = PomodoroReminderDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertPomodoroReminder(pomodoroReminder: PomodoroReminder) throws {
        modelContext.insert(pomodoroReminder)
        try modelContext.save()
    }

    func fetchPomodoroReminder() throws -> PomodoroReminder? {
        let descriptor = FetchDescriptor<PomodoroReminder>()
        return try modelContext.fetch(descriptor).first ?? nil
    }
}

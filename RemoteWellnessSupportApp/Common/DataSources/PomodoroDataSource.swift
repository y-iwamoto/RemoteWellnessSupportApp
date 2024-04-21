//
//  PomodoroDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/18.
//

import Foundation
import SwiftData

final class PomodoroDataSource {
    private let manager = ModelManager.shared
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = PomodoroDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertPomodoro(pomodoro: Pomodoro) throws {
        modelContext.insert(pomodoro)
        try modelContext.save()
    }

    func fetchPomodoros(predicate: Predicate<Pomodoro>?,
                        sortBy: [SortDescriptor<Pomodoro>] = []) throws -> [Pomodoro] {
        let descriptor = FetchDescriptor<Pomodoro>(predicate: predicate, sortBy: sortBy)
        return try modelContext.fetch(descriptor)
    }
}

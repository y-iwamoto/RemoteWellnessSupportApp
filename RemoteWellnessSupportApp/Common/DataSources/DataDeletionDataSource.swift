//
//  DataDeletionDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/31.
//

import Foundation
import SwiftData

final class DataDeletionDataSource {
    private let manager = ModelManager.shared
    private let modelContext: ModelContext

    @MainActor
    static let shared = DataDeletionDataSource()

    @MainActor
    private init() {
        modelContext = manager.modelContext
    }

    func deleteAllData() throws {
        try modelContext.delete(model: Hydration.self)
        try modelContext.delete(model: HydrationReminder.self)
        try modelContext.delete(model: PhysicalCondition.self)
        try modelContext.delete(model: PhysicalConditionReminder.self)
        try modelContext.delete(model: Profile.self)
        try modelContext.delete(model: Pomodoro.self)
        try modelContext.delete(model: PomodoroReminder.self)
        try modelContext.save()
    }
}

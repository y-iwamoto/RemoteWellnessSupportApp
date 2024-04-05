//
//  ModelManager.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/20.
//

import Foundation
import SwiftData

final class ModelManager {
    static let shared = ModelManager()

    let modelContainer: ModelContainer
    private lazy var _modelContext: ModelContext? = nil

    var modelContext: ModelContext {
        @MainActor get {
            if let context = _modelContext {
                return context
            } else {
                Task { @MainActor in
                    self.initializeModelContext()
                }
                return modelContainer.mainContext
            }
        }
    }

    private init() {
        let schema = Schema([Hydration.self, PhysicalCondition.self, PhysicalConditionReminder.self, Profile.self])
        do {
            modelContainer = try ModelContainer(for: schema)
        } catch {
            fatalError("ModelContainer initialization failed: \(error)")
        }
    }

    @MainActor private func initializeModelContext() {
        let context = modelContainer.mainContext
        _modelContext = context
    }
}

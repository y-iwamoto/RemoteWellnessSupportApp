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
                let context = modelContainer.mainContext
                _modelContext = context
                return context
            }
        }
    }

    private init() {
        let schema = Schema([PhysicalCondition.self, PhysicalConditionReminder.self])
        modelContainer = try! ModelContainer(for: schema)
    }
}

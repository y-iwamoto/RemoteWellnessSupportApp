//
//  PhysicalConditionDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/23.
//

import Foundation
import SwiftData

final class PhysicalConditionDataSource {
    private let manager = ModelManager.shared
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = PhysicalConditionDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertPhysicalCondition(physicalCondition: PhysicalCondition) throws {
        modelContext.insert(physicalCondition)
        try modelContext.save()
    }

    func updatePhysicalCondition(physicalCondition _: PhysicalCondition) throws {
        try modelContext.save()
    }

    func fetchPhysicalConditions(predicate: Predicate<PhysicalCondition>?,
                                 sortBy: [SortDescriptor<PhysicalCondition>] = []) throws -> [PhysicalCondition] {
        let descriptor = FetchDescriptor<PhysicalCondition>(predicate: predicate, sortBy: sortBy)
        return try modelContext.fetch(descriptor)
    }

    func removePhysicalCondition(_ physicalCondition: PhysicalCondition) throws {
        modelContext.delete(physicalCondition)
        try modelContext.save()
    }
}

//
//  HydrationDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation
import SwiftData

final class HydrationDataSource {
    private let manager = ModelManager.shared
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = HydrationDataSource()

    @MainActor
    private init() {
        modelContainer = manager.modelContainer
        modelContext = manager.modelContext
    }

    func insertHydration(hydration: Hydration) throws {
        modelContext.insert(hydration)
        try modelContext.save()
    }

    func fetchHydration(predicate: Predicate<Hydration>?,
                        sortBy: [SortDescriptor<Hydration>] = []) throws -> [Hydration] {
        let descriptor = FetchDescriptor<Hydration>(predicate: predicate, sortBy: sortBy)
        return try modelContext.fetch(descriptor)
    }

    func removeHydration(_ hydration: Hydration) throws {
        modelContext.delete(hydration)
        try modelContext.save()
    }

    func updateHydration(_ _: Hydration) throws {
        try modelContext.save()
    }
}

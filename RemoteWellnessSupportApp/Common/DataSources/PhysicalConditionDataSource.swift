//
//  PhysicalConditionDataSource.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/23.
//

import SwiftData

final class PhysicalConditionDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = PhysicalConditionDataSource()

    @MainActor
    private init() {
        // swiftlint:disable:next force_try
        modelContainer = try! ModelContainer(for: PhysicalCondition.self)
        modelContext = modelContainer.mainContext
    }

    func insertPhysicalCondition(physicalCondition: PhysicalCondition) throws {
        modelContext.insert(physicalCondition)
        try modelContext.save()
    }
}

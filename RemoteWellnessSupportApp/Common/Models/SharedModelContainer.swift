//
//  SharedModelContainer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/18.
//

import SwiftData

var SharedModelContainer: ModelContainer = {
    let schema = Schema([
        PhysicalCondition.self
    ])
    let modelConfiguration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: false
    )

    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

//
//  DataContainerViewModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/18.
//

import SwiftData
import SwiftUI

struct DataContainerViewModifier: ViewModifier {
    let container: ModelContainer

    init() {
        let schema = Schema([
            PhysicalCondition.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        container = try! ModelContainer(for: schema, configurations: [modelConfiguration])
    }

    func body(content: Content) -> some View {
        content
            .modelContainer(container)
    }
}

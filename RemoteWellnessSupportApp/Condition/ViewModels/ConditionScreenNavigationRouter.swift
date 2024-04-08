//
//  ConditionScreenNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/16.
//

import Foundation

enum ConditionScreenNavigationItem: Hashable {
    case physicalConditionEntryForm(date: Date)
    case reviewEntryForm
    case stepEntryForm
    case hydrationEntryForm(date: Date)
    case dailyPhysicalConditionList(date: Date)
    case weekPhysicalConditionList
    case weekHydrationList
    case dailyHydrationList(date: Date)
    case physicalConditionEditForm(physicalCondition: PhysicalCondition)
    case hydrationEditForm(hydration: Hydration)
    case selectedDatePhysicalConditionGraph(targetDate: Date)
    case selectedDateHydrationGraph(targetDate: Date)
}

final class ConditionScreenNavigationRouter: ObservableObject {
    @MainActor @Published var items: [ConditionScreenNavigationItem] = []
}

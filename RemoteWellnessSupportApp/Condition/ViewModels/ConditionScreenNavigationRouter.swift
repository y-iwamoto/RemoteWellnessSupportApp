//
//  ConditionScreenNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/16.
//

import Foundation

enum ConditionScreenNavigationItem: Hashable {
    case physicalConditionEntryForm
    case reviewEntryForm
    case stepEntryForm
    case hydrationEntryForm
    case dailyPhysicalConditionList(date: Date)
    case weekPhysicalConditionList
    case physicalConditionEditForm(physicalCondition: PhysicalCondition)
    case selectedDatePhysicalConditionGraph(targetDate: Date)
}

final class ConditionScreenNavigationRouter: ObservableObject {
    @MainActor @Published var items: [ConditionScreenNavigationItem] = []
}

//
//  ActivityEntryAreaViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/12.
//

import Foundation
import SwiftUI

class ActivityEntryAreaViewModel: ObservableObject {
    @Published var isExpanded = false
    let targetDate: Date

    init(targetDate: Date) {
        self.targetDate = targetDate
    }

    var topActivityNavigationLinks: [(destination: ConditionScreenNavigationItem, imageName: ConditionNavigationLink.ImageName)] {
        [
            (destination: ConditionScreenNavigationItem.physicalConditionEntryForm(date: targetDate),
             imageName: ConditionNavigationLink.ImageName.physicalConditionEntryForm),
            (destination: ConditionScreenNavigationItem.reviewEntryForm,
             imageName: ConditionNavigationLink.ImageName.reviewEntryForm)
        ]
    }

    var leftActivityNavigationLinks: [(destination: ConditionScreenNavigationItem, imageName: ConditionNavigationLink.ImageName)] {
        [
            (destination: ConditionScreenNavigationItem.stepEntryForm,
             imageName: ConditionNavigationLink.ImageName.stepEntryForm),
            (destination: ConditionScreenNavigationItem.hydrationEntryForm(date: targetDate),
             imageName: ConditionNavigationLink.ImageName.hydrationEntryForm)
        ]
    }

    func toggleExpanded() {
        withAnimation(Animation.linear(duration: 0.5)) {
            isExpanded.toggle()
        }
    }
}

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
    let topActivityNavigationLinks = [
        (destination: ConditionScreenNavigationItem.physicalConditionEntryForm(date: Date()),
         imageName: ConditionNavigationLink.ImageName.physicalConditionEntryForm),
        (destination: ConditionScreenNavigationItem.reviewEntryForm,
         imageName: ConditionNavigationLink.ImageName.reviewEntryForm)
    ]
    let leftActivityNavigationLinks = [
        (destination: ConditionScreenNavigationItem.stepEntryForm,
         imageName: ConditionNavigationLink.ImageName.stepEntryForm),
        (destination: ConditionScreenNavigationItem.hydrationEntryForm(date: Date()),
         imageName: ConditionNavigationLink.ImageName.hydrationEntryForm)
    ]

    func toggleExpanded() {
        withAnimation(Animation.linear(duration: 0.5)) {
            isExpanded.toggle()
        }
    }
}

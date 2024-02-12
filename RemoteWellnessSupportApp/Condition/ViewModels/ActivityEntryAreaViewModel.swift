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
        (destination: ConditionNavigationLink.Destination.physicalConditionEntryForm,
         imageName: ConditionNavigationLink.ImageName.physicalConditionEntryForm),
        (destination: ConditionNavigationLink.Destination.reviewEntryForm,
         imageName: ConditionNavigationLink.ImageName.reviewEntryForm)
    ]
    let leftActivityNavigationLinks = [
        (destination: ConditionNavigationLink.Destination.stepEntryForm,
         imageName: ConditionNavigationLink.ImageName.stepEntryForm),
        (destination: ConditionNavigationLink.Destination.hydrationEntryForm,
         imageName: ConditionNavigationLink.ImageName.hydrationEntryForm)
    ]

    func toggleExpanded() {
        withAnimation(Animation.linear(duration: 0.5)) {
            isExpanded.toggle()
        }
    }

    func destinationView(for destination: ConditionNavigationLink.Destination) -> AnyView {
        switch destination {
        case .physicalConditionEntryForm:
            return AnyView(PhysicalConditionEntryForm())
        case .reviewEntryForm:
            return AnyView(ReviewEntryForm())
        case .stepEntryForm:
            return AnyView(StepEntryForm())
        case .hydrationEntryForm:
            return AnyView(HydrationEntryForm())
        }
    }
}

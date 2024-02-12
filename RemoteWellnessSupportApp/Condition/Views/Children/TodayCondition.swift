//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @State private var isExpanded = false
    @State private var selectedDestination: CondtionNavigationLinkConst.Destination?

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                if isExpanded {
                    HStack(spacing: 3) {
                        ActivityEntryNavigationLink(destination: CondtionNavigationLinkConst.Destination.physicalConditionEntryForm,
                                                    imageName: CondtionNavigationLinkConst.ImageName.physicalConditionEntryForm)
                        ActivityEntryNavigationLink(destination: CondtionNavigationLinkConst.Destination.reviewEnrtyForm,
                                                    imageName: CondtionNavigationLinkConst.ImageName.reviewEnrtyForm)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                HStack {
                    Spacer()

                    if isExpanded {
                        VStack {
                            ActivityEntryNavigationLink(destination: CondtionNavigationLinkConst.Destination.stepEntryForm,
                                                        imageName: CondtionNavigationLinkConst.ImageName.stepEntryForm)
                            ActivityEntryNavigationLink(destination: CondtionNavigationLinkConst.Destination.hydrationEntryForm,
                                                        imageName: CondtionNavigationLinkConst.ImageName.hydrationEntryForm)
                        }
                    }

                    PlusButton(action: {
                        withAnimation(Animation.linear(duration: 0.5)) {
                            isExpanded.toggle()
                        }
                    })
                }
            }
            .navigationDestination(for: CondtionNavigationLinkConst.Destination.self) { destination in
                switch destination {
                case .physicalConditionEntryForm:
                    PhysicalConditionEntryForm()
                case .reviewEnrtyForm:
                    ReviewEntryForm()
                case .stepEntryForm:
                    StepEntryForm()
                case .hydrationEntryForm:
                    HydrationEntryForm()
                }
            }
        }
    }
}

#Preview {
    TodayCondition()
}

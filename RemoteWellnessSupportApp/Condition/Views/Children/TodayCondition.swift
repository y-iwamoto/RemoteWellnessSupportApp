//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @State private var isExpanded = false
    @State private var selectedDestination: ConditionNavigationLink.Destination?

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                if isExpanded {
                    HStack(spacing: 3) {
                        ActivityEntryNavigationLink(destination: ConditionNavigationLink.Destination.physicalConditionEntryForm,
                                                    imageName: ConditionNavigationLink.ImageName.physicalConditionEntryForm)
                        ActivityEntryNavigationLink(destination: ConditionNavigationLink.Destination.reviewEnrtyForm,
                                                    imageName: ConditionNavigationLink.ImageName.reviewEntryForm)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                HStack {
                    Spacer()

                    if isExpanded {
                        VStack {
                            ActivityEntryNavigationLink(destination: ConditionNavigationLink.Destination.stepEntryForm,
                                                        imageName: ConditionNavigationLink.ImageName.stepEntryForm)
                            ActivityEntryNavigationLink(destination: ConditionNavigationLink.Destination.hydrationEntryForm,
                                                        imageName: ConditionNavigationLink.ImageName.hydrationEntryForm)
                        }
                    }

                    PlusButton(action: {
                        withAnimation(Animation.linear(duration: 0.5)) {
                            isExpanded.toggle()
                        }
                    })
                }
            }
            .navigationDestination(for: ConditionNavigationLink.Destination.self) { destination in
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

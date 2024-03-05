//
//  ActivityEntryArea.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/13.
//

import SwiftUI

struct ActivityEntryArea: View {
    @ObservedObject var viewModel = ActivityEntryAreaViewModel()
    let spacing: CGFloat = 3

    var body: some View {
        VStack {
            Spacer()

            if viewModel.isExpanded {
                HStack(spacing: spacing) {
                    ForEach(viewModel.topActivityNavigationLinks.indices, id: \.self) { index in
                        ActivityEntryNavigationLink(destination: viewModel.topActivityNavigationLinks[index].destination,
                                                    imageName: viewModel.topActivityNavigationLinks[index].imageName)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            HStack {
                Spacer()

                if viewModel.isExpanded {
                    VStack(spacing: spacing) {
                        ForEach(viewModel.leftActivityNavigationLinks.indices, id: \.self) { index in
                            ActivityEntryNavigationLink(destination: viewModel.leftActivityNavigationLinks[index].destination,
                                                        imageName: viewModel.leftActivityNavigationLinks[index].imageName)
                        }
                    }
                }

                PlusButton {
                    viewModel.toggleExpanded()
                }
            }
        }
        .navigationDestination(for: ConditionNavigationLink.Destination.self) { destination in
            destinationView(for: destination)
        }
    }

    @ViewBuilder
    private func destinationView(for destination: ConditionNavigationLink.Destination) -> some View {
        switch destination {
        case .physicalConditionEntryForm:
            PhysicalConditionCreateForm()
        case .reviewEntryForm:
            ReviewEntryForm()
        case .stepEntryForm:
            StepEntryForm()
        case .hydrationEntryForm:
            HydrationEntryForm()
        }
    }
}

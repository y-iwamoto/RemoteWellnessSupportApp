//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @ObservedObject var viewModel = TodayConditionViewModel()

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                if viewModel.isExpanded {
                    HStack(spacing: 3) {
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
                        VStack {
                            ForEach(viewModel.leftActivityNavigationLinks.indices, id: \.self) { index in
                                ActivityEntryNavigationLink(destination: viewModel.leftActivityNavigationLinks[index].destination,
                                                            imageName: viewModel.leftActivityNavigationLinks[index].imageName)
                            }
                        }
                    }

                    PlusButton(action: viewModel.toggleExpanded)
                }
            }
            .navigationDestination(for: ConditionNavigationLink.Destination.self) { destination in
                viewModel.destinationView(for: destination)
            }
        }
    }
}

#Preview {
    TodayCondition()
}

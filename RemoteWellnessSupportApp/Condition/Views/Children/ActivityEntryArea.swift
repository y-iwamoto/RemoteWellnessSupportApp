//
//  ActivityEntryArea.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/13.
//

import SwiftUI

struct ActivityEntryArea: View {
    @ObservedObject var viewModel: ActivityEntryAreaViewModel
    let targetDate: Date
    let spacing: CGFloat = 3

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = ObservedObject(wrappedValue: ActivityEntryAreaViewModel(targetDate: targetDate))
    }

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
                .padding(.trailing, 20)
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
    }
}

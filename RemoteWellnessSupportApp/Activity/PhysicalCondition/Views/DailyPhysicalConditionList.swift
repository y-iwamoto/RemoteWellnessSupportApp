//
//  DailyPhysicalConditionList.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/03.
//

import SwiftUI

struct DailyPhysicalConditionList: View {
    let targetDate: Date
    @StateObject var viewModel: DailyPhysicalConditionListViewModel

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: DailyPhysicalConditionListViewModel(targetDate: targetDate))
    }

    var body: some View {
        Text("体調一覧 \(targetDate.toString(format: "MM/dd"))")
        content
            .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
            .navigationDestination(for: PhysicalCondition.self) { selectedCondition in
                PhysicalConditionEditForm(physicalCondition: selectedCondition)
            }
            .onAppear {
                viewModel.fetchPhysicalConditions()
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.physicalConditions.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.physicalConditions, id: \.self) { item in
                    HStack {
                        NavigationLink(value: item) {
                            Text(item.entryDate.toString(format: "HH:mm"))
                            Spacer()
                            if let rating = PhysicalConditionRating(rawValue: item.rating) {
                                Text("\(rating.label)")
                                Image(systemName: rating.imageName)
                            } else {
                                Text("評価なし")
                            }
                        }
                    }
                }
                .onDelete(perform: remove)
            }
        }
    }

    private func remove(index: IndexSet) {
        viewModel.deletePhysicalCondition(at: index)
    }
}

// #Preview {
//    SelectedDatePhysicalConditionListView()
// }

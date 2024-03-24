//
//  WorkDaySelectView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import SwiftUI

struct WorkDaySelectView: View {
    @Binding var workDays: [WorkDay]
    @StateObject var viewModel: WorkDaySelectViewModel
    @EnvironmentObject private var router: ProfileNavigationRouter

    init(workDays: Binding<[WorkDay]>) {
        _workDays = workDays
        _viewModel = StateObject(wrappedValue: WorkDaySelectViewModel(workDays: workDays.wrappedValue))
    }

    var body: some View {
        VStack {
            Text("普段勤務している曜日を教えて下さい")
                .font(.title3)

            VStack(spacing: 20) {
                ForEach(viewModel.daysOfWeek, id: \.self) { group in
                    HStack(spacing: 20) {
                        ForEach(group, id: \.self) { dayOfWeek in
                            Button {
                                viewModel.selectDayOfWeek(dayOfWeek)
                            } label: {
                                Text(dayOfWeek.labelName)
                                    .frame(width: 100, height: 100)
                                    .background(dayOfWeek.selected ? Color.green : Color.gray)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }

            CommonButtonView(title: "次へ進む") {
                let newWorkDays = viewModel.assignDayOfWeek(workDays)
                if !newWorkDays.isEmpty {
                    workDays = newWorkDays
                    router.items.append(.workTimeInput)
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}

// #Preview {
//    WorkDaySelectView()
// }

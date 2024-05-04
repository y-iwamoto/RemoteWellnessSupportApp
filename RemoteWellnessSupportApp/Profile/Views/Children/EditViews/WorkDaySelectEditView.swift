//
//  WorkDaySelectEditView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/02.
//

import SwiftUI

struct WorkDaySelectEditView: View {
    var profile: Profile
    @StateObject var viewModel: WorkDaySelectEditViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(profile: Profile) {
        self.profile = profile
        _viewModel = StateObject(
            wrappedValue:
            WorkDaySelectEditViewModel(profile: profile))
    }

    var body: some View {
        CommonLayoutView(
            title: "変更したい勤務曜日を選択して下さい",
            buttonTitle: "保存する",
            content: {
                VStack(spacing: 20) {
                    ForEach(viewModel.daysOfWeek, id: \.self) { group in
                        HStack(spacing: 20) {
                            ForEach(group, id: \.self) { dayOfWeek in
                                Button {
                                    viewModel.selectDayOfWeek(dayOfWeek)
                                } label: {
                                    Text(dayOfWeek.labelName)
                                        .frame(minWidth: 70, minHeight: 70)
                                        .background(dayOfWeek.selected ? Color.green : Color.gray)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
            },
            buttonAction: {
                if viewModel.updateDaysOfWeek() {
                    router.items.removeLast()
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}

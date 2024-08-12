//
//  ProfileSettingView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import SwiftUI

struct ProfileSettingView: View {
    @StateObject var viewModel = ProfileSettingViewModel()
    @EnvironmentObject var router: SettingScreenNavigationRouter

    var body: some View {
        VStack {
            Text("プロフィール")
            if let profile = viewModel.profileRecord {
                List {
                    Section(header: Text("勤務曜日")) {
                        HStack {
                            Text(viewModel.workDaysLabels)
                            Spacer()
                            Button(action: {
                                router.items.append(SettingScreenNavigationItem.workDaySelectEdit(profile: profile))
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                        }
                    }

                    Section(header: Text("勤務・休憩時間")) {
                        HStack {
                            Text("勤務時間")
                            Text("\(profile.workTimeFrom.toString(format: "HH:mm"))~\(profile.workTimeTo.toString(format: "HH:mm"))")
                            Spacer()
                            Button(action: {
                                router.items.append(SettingScreenNavigationItem.workTimeEditInput(profile: profile))
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                        }
                        HStack {
                            Text("休憩時間")
                            ForEach(profile.restTimePeriods, id: \.self) { period in
                                Text("\(period.fromTime.toString(format: "HH:mm"))~\(period.toTime.toString(format: "HH:mm"))")
                            }
                            Spacer()
                            Button(action: {
                                router.items.append(SettingScreenNavigationItem.restTimeEditInput(profile: profile))
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                        }
                    }

                    Section(header: Text("１時間あたり目標値")) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("水分摂取")
                                    Text("\(profile.hydrationGoal.roundedString)ml")
                                }
                                HStack {
                                    Text("アクティビティ")
                                    Text("\(profile.stepGoal.roundedString)歩")
                                }
                            }
                            Spacer()
                            Button(action: {
                                router.items.append(SettingScreenNavigationItem.goalSettingEditInput(profile: profile))
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                        }
                    }
                }

            } else {
                Text("プロファイル情報が存在しません")
            }
        }
    }
}

#Preview {
    ProfileSettingView()
}

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

                    Section(header: Text("１日あたり目標値")) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("水分摂取")
                                    Text("\(profile.hydrationGoal.roundedString)ml")
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

                    Section(header: Text("ヘルスケア連携項目設定")) {
                        HStack {
                            Text("アプリ設定を開く")
                            Spacer()
                            Button(action: {
                                viewModel.isOpenAlert = true
                            }, label: {
                                Image(systemName: "arrow.up.forward.app.fill")
                            })
                        }
                    }
                }

            } else {
                Text("プロファイル情報が存在しません")
            }
        }
        .alert("ヘルスケア設定の案内", isPresented: $viewModel.isOpenAlert) {
            Button("OK") {
                openAppSettings()
            }
        } message: {
            Text("""
            1. まず画面左上の「設定」をタップしてください。
            2. 次に「ヘルスケア」をタップしてください。
            3. さらに「データアクセスとデバイス」を選択してください。
            4. 対象のアプリ名を選び、読み取り権限をオン・オフを確認または変更してください。
            5. 設定が完了したら、アプリに戻ってください。
            """)
        }
    }

    private func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

#Preview {
    ProfileSettingView()
}

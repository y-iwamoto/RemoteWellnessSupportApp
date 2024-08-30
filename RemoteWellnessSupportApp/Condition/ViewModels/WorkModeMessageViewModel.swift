//
//  WorkModeMessageViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/30.
//

import Foundation
import SwiftUI

final class WorkModeMessageViewModel: BaseViewModel {
    private let profileDataSource: ProfileDataSource
    var profile: Profile?
    @Published var workStatus = WorkStatus.beforeWork

    init(profileDataSource: ProfileDataSource = .shared) {
        self.profileDataSource = profileDataSource
    }

    func fetchWorkStatus() {
        do {
            profile = try profileDataSource.fetchProfile()
            if let profile {
                updateWorkStatus(basedOn: profile)
            }
        } catch {
            setError(withMessage: "プロフィール取得処理に失敗しました", error: error)
        }
    }

    private func updateWorkStatus(basedOn profile: Profile) {
        let nowTime = Date()
        // 現在の日付を基準にprofileの時間を設定
        func convertToToday(date: Date) -> Date? {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone.current
            let nowComponents = calendar.dateComponents([.year, .month, .day], from: nowTime)
            var dateComponents = calendar.dateComponents([.hour, .minute], from: date)
            dateComponents.year = nowComponents.year
            dateComponents.month = nowComponents.month
            dateComponents.day = nowComponents.day
            return calendar.date(from: dateComponents)
        }

        guard let workTimeFromToday = convertToToday(date: profile.workTimeFrom),
              let workTimeToToday = convertToToday(date: profile.workTimeTo) else {
            workStatus = .unknown
            return
        }

        let restTimePeriodsToday = profile.restTimePeriods.compactMap { period -> (fromTime: Date, toTime: Date)? in
            guard let fromTime = convertToToday(date: period.fromTime),
                  let toTime = convertToToday(date: period.toTime) else {
                return nil
            }
            return (fromTime: fromTime, toTime: toTime)
        }

        // 勤務時間の範囲内かどうかを判定
        if nowTime < workTimeFromToday {
            workStatus = .beforeWork
        } else if nowTime >= workTimeFromToday, nowTime <= workTimeToToday {
            // 休憩時間に該当するかどうかを確認
            if let restPeriod = restTimePeriodsToday.first(where: { $0.fromTime <= nowTime && nowTime <= $0.toTime }) {
                if nowTime == restPeriod.fromTime {
                    workStatus = .onBreak
                } else if nowTime == restPeriod.toTime {
                    workStatus = .afterBreak
                } else {
                    workStatus = .onBreak
                }
            } else {
                if nowTime == workTimeFromToday {
                    workStatus = .workStarted
                } else if nowTime == workTimeToToday {
                    workStatus = .beforeLeaving
                } else {
                    workStatus = .workStarted
                }
            }
        } else {
            workStatus = .afterWork
        }
    }
}

enum WorkStatus {
    case beforeWork // 出勤前
    case workStarted // 勤務中（開始）
    case onBreak // 休憩中
    case afterBreak // 勤務中（休憩後）
    case beforeLeaving // 勤務退勤前
    case afterWork // 退勤後
    case unknown

    var title: String {
        switch self {
        case .beforeWork:
            "勤務前です"
        case .workStarted:
            "勤務中です"
        case .onBreak:
            "休憩中です"
        case .afterBreak:
            "勤務中です"
        case .beforeLeaving:
            "勤務中です"
        case .afterWork:
            "勤務終了"
        case .unknown:
            ""
        }
    }

    var color: Color {
        switch self {
        case .beforeWork, .afterWork:
            Color.blue
        case .workStarted, .afterBreak, .beforeLeaving:
            Color.green
        case .onBreak:
            Color.red
        case .unknown:
            Color.gray.opacity(0.5)
        }
    }

    var motivationalMessage: String {
        switch self {
        case .beforeWork:
            "新しい一日が始まります！今日も頑張っていきましょう！"
        case .workStarted:
            "素晴らしいスタートです！目標に向かって一歩一歩進んでいきましょう！"
        case .onBreak:
            "しっかり休んで、次の作業に備えましょう！リフレッシュは大切です！"
        case .afterBreak:
            "休憩お疲れさまでした！後半も集中していきましょう！"
        case .beforeLeaving:
            "あと少し！最後まで気を抜かず、やり遂げましょう！"
        case .afterWork:
            "お疲れさまでした！今日も一日頑張りましたね！しっかり休んでください。"
        case .unknown:
            "ステータスを取得中です"
        }
    }
}

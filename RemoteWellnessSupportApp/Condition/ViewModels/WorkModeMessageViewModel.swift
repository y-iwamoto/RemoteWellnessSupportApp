//
//  WorkModeMessageViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/30.
//

import Foundation

final class WorkModeMessageViewModel: BaseViewModel {
    private let profileDataSource: ProfileDataSource
    var profile: Profile?
    @Published var workStatus = WorkStatus.unknown

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

        let (workTimeFromToday, workTimeToToday) = workTimeAdjustedForToday(profile: profile, nowTime: nowTime)

        guard let workTimeFromToday, let workTimeToToday else {
            workStatus = .unknown
            return
        }
        let restTimePeriodsToday = restTimePeriodsAdjustedForToday(profile: profile, nowTime: nowTime)

        determineWorkStatus(nowTime: nowTime, workTimeFromToday: workTimeFromToday,
                            workTimeToToday: workTimeToToday, restTimePeriodsToday: restTimePeriodsToday)
    }

    private func convertToToday(date: Date, nowTime: Date) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: nowTime)
        var dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        dateComponents.year = nowComponents.year
        dateComponents.month = nowComponents.month
        dateComponents.day = nowComponents.day
        return calendar.date(from: dateComponents)
    }

    private func workTimeAdjustedForToday(profile: Profile, nowTime: Date) -> (workTimeFromToday: Date?, workTimeToToday: Date?) {
        let workTimeFromToday = convertToToday(date: profile.workTimeFrom, nowTime: nowTime)
        let workTimeToToday = convertToToday(date: profile.workTimeTo, nowTime: nowTime)
        return (workTimeFromToday: workTimeFromToday, workTimeToToday: workTimeToToday)
    }

    private func restTimePeriodsAdjustedForToday(profile: Profile, nowTime: Date) -> [(fromTime: Date, toTime: Date)] {
        let restTimePeriodsToday = profile.restTimePeriods.compactMap { period -> (fromTime: Date, toTime: Date)? in
            guard let fromTime = convertToToday(date: period.fromTime, nowTime: nowTime),
                  let toTime = convertToToday(date: period.toTime, nowTime: nowTime) else {
                return nil
            }
            return (fromTime: fromTime, toTime: toTime)
        }
        return restTimePeriodsToday
    }

    private func determineWorkStatus(nowTime: Date, workTimeFromToday: Date, workTimeToToday: Date,
                                     restTimePeriodsToday: [(fromTime: Date, toTime: Date)]) {
        if nowTime < workTimeFromToday {
            workStatus = .beforeWork
        } else if nowTime >= workTimeFromToday, nowTime <= workTimeToToday {
            determineRestOrWorkStatus(nowTime: nowTime, workTimeFromToday: workTimeFromToday,
                                      workTimeToToday: workTimeToToday, restTimePeriodsToday: restTimePeriodsToday)
        } else {
            workStatus = .afterWork
        }
    }

    private func determineRestOrWorkStatus(nowTime: Date, workTimeFromToday: Date, workTimeToToday: Date,
                                           restTimePeriodsToday: [(fromTime: Date, toTime: Date)]) {
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
    }
}

//
//  BaseSelectedDateGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/06.
//

import Foundation

class BaseSelectedDateGraphViewModel: ObservableObject {
    let profileDataSource: ProfileDataSource
    let targetDate: Date
    let noEntryValueForSpecificTime = 0

    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(profileDataSource: ProfileDataSource = .shared, targetDate: Date = Date()) {
        self.profileDataSource = profileDataSource
        self.targetDate = targetDate
    }

    func calculateWorkHoursRange() throws -> ClosedRange<Int> {
        let calendar = Calendar.current
        var startHour = 0
        var endHour = 9
        do {
            guard let profile = try profileDataSource.fetchProfile() else {
                throw SwiftDataError.notFound(description: "Failed to fetch Profile")
            }
            startHour = calendar.component(.hour, from: profile.workTimeFrom)
            endHour = calendar.component(.hour, from: profile.workTimeTo)
        } catch {
            throw error
        }
        return startHour ... endHour
    }

    func calculateDateRange() throws -> [Date] {
        let calendar = Calendar.current
        var dateArray: [Int] = []
        do {
            guard let profile = try profileDataSource.fetchProfile() else {
                throw SwiftDataError.notFound(description: "Failed to fetch Profile")
            }
            dateArray = profile.workDays.map(\.rawValue)
        } catch {
            throw error
        }

        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        return dateArray.map { offset -> Date in
            let diff = (offset - ((weekday - 2) + 7) % 7)
            let startOfDay = calendar.date(byAdding: .day, value: diff, to: today)!
            return calendar.startOfDay(for: startOfDay)
        }.sorted()
    }

    func dateOneWeekAgo() -> Date {
        let currentTime = Date()
        return Calendar.current.date(byAdding: .day, value: -7, to: currentTime)!
    }

    func setError(withMessage message: String, error: Error? = nil) {
        isErrorAlert = true
        errorMessage = message
        print("error", error?.localizedDescription ?? "Some error has occurred")
    }
}

//
//  HydrationProgressViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/25.
//

import Foundation

class HydrationProgressViewModel: BaseViewModel {
    private let hydrationDataSource: HydrationDataSource
    private let profileDataSource: ProfileDataSource

    @Published var hydrationGoalProgress = CGFloat(0.0)
    @Published var currentTotalHydrationIntake = 0
    @Published var totalHydrationGoal = 0

    init(hydrationDataSource: HydrationDataSource = .shared, profileDataSource: ProfileDataSource = .shared) {
        self.hydrationDataSource = hydrationDataSource
        self.profileDataSource = profileDataSource
    }

    func aggregateHydration() {
        do {
            let hydrations = try fetchTodayHydration()
            totalHydrationGoal = try calculateTotalHydrationGoal()
            currentTotalHydrationIntake = calculateTotalHydration(hydrations: hydrations)
            hydrationGoalProgress = calculateHydrationProgress()
        } catch {
            setError(withMessage: "水分摂取データの取得に失敗しました")
        }
    }

    private func fetchTodayHydration() throws -> [Hydration] {
        let predicate = try createPredicateForTargetDate()
        return try hydrationDataSource.fetchHydration(predicate: predicate)
    }

    private func calculateTotalHydrationGoal() throws -> Int {
        guard let profile = try profileDataSource.fetchProfile() else {
            throw SwiftDataError.notFound(description: "Failed to fetch Profile")
        }
        return Int(profile.hydrationGoal)
    }

    private func calculateTotalHydration(hydrations: [Hydration]) -> Int {
        hydrations.reduce(into: 0) { total, hydration in
            total += hydration.rating
        }
    }

    private func calculateHydrationProgress() -> CGFloat {
        CGFloat(Double(currentTotalHydrationIntake) / Double(totalHydrationGoal))
    }

    private func createPredicateForTargetDate() throws -> Predicate<Hydration> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            throw DateError.calculationFailed(description: "Failed to calculate the end of day")
        }
        let predicate: Predicate<Hydration> = #Predicate<Hydration> { hydration in
            hydration.entryDate >= startOfDay && hydration.entryDate < endOfDay
        }
        return predicate
    }
}

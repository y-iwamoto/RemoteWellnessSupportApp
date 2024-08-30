//
//  WorkStatus.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/30.
//

import Foundation
import SwiftUI

enum WorkStatus {
    case beforeWork // 出勤前
    case workStarted // 勤務中（開始）
    case onBreak // 休憩中
    case afterBreak // 勤務中（休憩後）
    case beforeLeaving // 勤務退勤前
    case afterWork // 退勤後
    case unknown

    var title: String {
        WorkStatus.titles[self] ?? ""
    }

    var color: Color {
        WorkStatus.colors[self] ?? .gray.opacity(0.5)
    }

    var motivationalMessage: String {
        WorkStatus.messages[self] ?? "ステータスを取得中です"
    }

    private static let titles: [WorkStatus: String] = [
        .beforeWork: "勤務前です",
        .workStarted: "勤務中です",
        .onBreak: "休憩中です",
        .afterBreak: "勤務中です",
        .beforeLeaving: "勤務中です",
        .afterWork: "勤務終了",
        .unknown: ""
    ]

    private static let colors: [WorkStatus: Color] = [
        .beforeWork: .blue,
        .workStarted: .green,
        .onBreak: .red,
        .afterBreak: .green,
        .beforeLeaving: .green,
        .afterWork: .blue,
        .unknown: .gray.opacity(0.5)
    ]

    private static let messages: [WorkStatus: String] = [
        .beforeWork: "新しい一日が始まります！今日も頑張っていきましょう！",
        .workStarted: "素晴らしいスタートです！目標に向かって一歩一歩進んでいきましょう！",
        .onBreak: "しっかり休んで、次の作業に備えましょう！リフレッシュは大切です！",
        .afterBreak: "休憩お疲れさまでした！後半も集中していきましょう！",
        .beforeLeaving: "あと少し！最後まで気を抜かず、やり遂げましょう！",
        .afterWork: "お疲れさまでした！今日も一日頑張りましたね！しっかり休んでください。",
        .unknown: "ステータスを取得中です"
    ]
}

//
//  PomodoroTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import SwiftUI

struct PomodoroTimer: View {
    @StateObject var viewModel = PomodoroTimerViewModel()
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                CircleProgress(progress: CGFloat(viewModel.secondsLeft) /
                    CGFloat(viewModel.currentMaxTime))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(viewModel.timerMode == .running ? Color.green :
                        (viewModel.timerMode == .breakMode ? Color.blue : Color.red))
                    .animation(.linear, value: viewModel.secondsLeft)

                VStack {
                    Text("\(formatPomodoroTime(viewModel.secondsLeft))")
                        .font(.largeTitle)
                        .padding()

                    Text("本日のタスク完了数：\(viewModel.completedPomodoroCount)")
                        .font(.title3)
                }
            }
            .padding(40)

            if viewModel.timerMode == .initial {
                if viewModel.currentMaxTime == PomodoroTimerViewModel.MaxTimer {
                    Button("作業開始") {
                        viewModel.startTimer()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                } else if viewModel.currentMaxTime == PomodoroTimerViewModel.BreakTime {
                    Button("休憩開始") {
                        viewModel.startBraekMode()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            } else if viewModel.timerMode == .running || viewModel.timerMode == .breakMode {
                Button("Pause") {
                    viewModel.pauseTimer()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Capsule())
            } else if viewModel.timerMode == .paused {
                HStack {
                    Button("Resume") {
                        viewModel.resumeTimer()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())

                    Button("Reset") {
                        viewModel.resetTimer()
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
        }
    }

    private func formatPomodoroTime(_ second: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .full
        formatter.calendar?.locale = Locale(identifier: "ja_JP")

        let formattedString = formatter.string(from: TimeInterval(second))!
        return formattedString
    }
}

#Preview {
    PomodoroTimer()
}

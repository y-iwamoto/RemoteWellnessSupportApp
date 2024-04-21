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
                
                CircleProgress(progress: viewModel.progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(viewModel.foregroundColor)
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
            timerModeView
        }
    }

    @ViewBuilder
       var timerModeView: some View {
           switch viewModel.timerMode {
           case .initial:
               if viewModel.currentMaxTime == PomodoroTimerViewModel.MaxTimer {
                   PomodoroButton(title: "作業開始", backgroundColor: Color.green) {
                       viewModel.startTimer()
                   }
               } else if viewModel.currentMaxTime == PomodoroTimerViewModel.BreakTime {
                   PomodoroButton(title: "休憩開始", backgroundColor: Color.blue) {
                       viewModel.startBraekMode()
                   }
               }
           case .running, .breakMode:
               PomodoroButton(title: "停止", backgroundColor: Color.red) {
                   viewModel.pauseTimer()
               }
           case .paused:
               HStack {
                   PomodoroButton(title: "再開", backgroundColor: Color.green) {
                       viewModel.resumeTimer()
                   }
                   PomodoroButton(title: "リセット", backgroundColor: Color.gray) {
                       viewModel.resetTimer()
                   }
               }
           }
       }
    
    private func formatPomodoroTime(_ second: Int) -> String {
        let formatter = viewModel.formatter

        let formattedString = formatter.string(from: TimeInterval(second))!
        return formattedString
    }
}

#Preview {
    PomodoroTimer()
}

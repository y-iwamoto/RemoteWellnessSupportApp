//
//  ScheduleTimeSelectView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/18.
//

import SwiftUI

struct ScheduleTimeSelectView: View {
    @Binding var timeSelections: [TimeSelection]

    var body: some View {
        List {
            ForEach($timeSelections.indices, id: \.self) { index in
                TimePicker(timeSelection: $timeSelections[index], label: "時間")
            }
            .onDelete(perform: removeTimeSelection)

            Button(action: addTimeSelection) {
                Label("追加", systemImage: "plus.circle.fill")
            }
        }
        .listStyle(PlainListStyle())
    }

    private func addTimeSelection() {
        timeSelections.append(TimeSelection())
    }

    private func removeTimeSelection(at offsets: IndexSet) {
        timeSelections.remove(atOffsets: offsets)
    }
}

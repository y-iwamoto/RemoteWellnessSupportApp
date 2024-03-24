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
        TimeSelectionListView(
            items: $timeSelections,
            contentView: { TimePicker(timeSelection: $0, label: "時間") },
            addItem: { timeSelections.append(TimeSelection()) },
            removeItem: { timeSelections.remove(atOffsets: $0) }
        )
    }
}

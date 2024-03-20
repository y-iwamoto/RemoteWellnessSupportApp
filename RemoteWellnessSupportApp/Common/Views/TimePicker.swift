//
//  TimePicker.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/18.
//

import SwiftUI

struct TimePicker: View {
    @Binding var timeSelection: TimeSelection
    let label: String
    
    var body: some View {
        DatePicker(
            label,
            selection: $timeSelection.selectedTime,
            displayedComponents: .hourAndMinute
        )
        .datePickerStyle(GraphicalDatePickerStyle())
    }
}

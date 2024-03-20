//
//  IntervalTimeSelectView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/18.
//

import SwiftUI

struct IntervalTimeSelectView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    let minutes = Array(0...59)
    let hours = Array(0...23)

    var body: some View {
        VStack {
            HStack {
                Picker("Hours", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        Text("\(hour) 時間")
                    }
                }
                .labelsHidden()
                .clipped()
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)

                Picker("Minutes", selection: $selectedMinute) {
                    ForEach(minutes, id: \.self) { minute in
                        Text("\(minute) 分")
                    }
                }
                .labelsHidden()
                .clipped()
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)

            }
        }
    }
}

//
//  Date+Extensions.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy/MM/dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self)
    }
}

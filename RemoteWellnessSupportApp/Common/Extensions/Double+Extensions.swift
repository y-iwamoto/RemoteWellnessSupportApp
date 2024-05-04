//
//  Double+Extensions.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/01.
//

import Foundation

extension Double {
    var roundedString: String {
        "\(Int(rounded()))"
    }

    func toString(withDecimalPlaces places: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = places
        formatter.maximumFractionDigits = places
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

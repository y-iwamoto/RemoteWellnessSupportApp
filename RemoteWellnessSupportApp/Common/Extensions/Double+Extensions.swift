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

    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    func toString(withDecimalPlaces places: Int) -> String {
        Double.formatter.minimumFractionDigits = places
        Double.formatter.maximumFractionDigits = places
        return Double.formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

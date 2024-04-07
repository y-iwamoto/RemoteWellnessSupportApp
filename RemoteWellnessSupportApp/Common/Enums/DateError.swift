//
//  DateError.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/07.
//

import Foundation

enum DateError: Error {
    case calculationFailed(description: String)

    case invalidDate(description: String)
}

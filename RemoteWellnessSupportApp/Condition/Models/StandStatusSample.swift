//
//  StandStatusSample.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/08.
//

import Foundation

struct StandStatusSample: GraphColumnHaving {
    var entryDate: Date
    var rating: Int
    var status: StandStatus {
        StandStatus(rawValue: rating) ?? .idle
    }
}

//
//  SelectableItem.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/22.
//

import Foundation

protocol SelectableItem: Identifiable {
    var imageName: String { get }
    var label: String { get }
}

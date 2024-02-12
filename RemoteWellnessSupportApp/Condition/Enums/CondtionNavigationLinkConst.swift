//
//  CondtionNavigationLinkConst.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/12.
//

import Foundation

enum CondtionNavigationLinkConst {
    enum Destination {
        case physicalConditionEntryForm, reviewEnrtyForm, stepEntryForm, hydrationEntryForm
    }

    enum ImageName: String {
        case physicalConditionEntryForm = "medical.thermometer.fill"
        case reviewEnrtyForm = "book.fill"
        case stepEntryForm = "shoeprints.fill"
        case hydrationEntryForm = "takeoutbag.and.cup.and.straw.fill"
    }
}

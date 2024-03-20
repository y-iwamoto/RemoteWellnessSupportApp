//
//  DateArrayTransformer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation
import CoreData

class DateArrayTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let dateArray = value as? [Date] else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: dateArray, requiringSecureCoding: false)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSDate.self], from: data) as? [Date]
    }
}

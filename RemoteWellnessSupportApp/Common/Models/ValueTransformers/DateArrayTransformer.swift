//
//  DateArrayTransformer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import CoreData
import Foundation
import os.log

class DateArrayTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let dateArray = value as? [Date] else { return nil }
        do {
            return try JSONEncoder().encode(dateArray)
        } catch {
            os_log("Error transforming date array to data: %@", log: OSLog.default, type: .error, error.localizedDescription)
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            return try JSONDecoder().decode([Date].self, from: data)
        } catch {
            os_log("Error transforming data to date array: %@", log: OSLog.default, type: .error, error.localizedDescription)
            return nil
        }
    }
}

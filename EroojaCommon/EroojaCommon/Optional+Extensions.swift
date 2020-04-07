//
//  Optional+Extensions.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/04/07.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

func isOptional<Type>(_ instance: Type) -> Bool {
    guard let displayStyle = Mirror(reflecting: instance).displayStyle else { return false }
    return displayStyle == .optional
}

public extension Swift.Optional where Wrapped == String {
    var countZeroIfNil: Int {
        guard let strongSelf = self else {
            return 0
        }
        return strongSelf.count
    }
    
    var isEmptyOrNil: Bool {
        guard let strongSelf = self else {
            return true
        }
        return strongSelf.isEmpty
    }
    
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }

}

public extension Optional where Wrapped == NSObject {
    var isNilOrNull: Bool {
        guard let object = self else { return true }
        return object is NSNull
    }
}

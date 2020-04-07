//
//  AnyObject+AssociatedObject.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/04/07.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public func getAssociated<ValueType: AnyObject>(_ base: AnyObject, key: UnsafePointer<UInt8>, initializer: () -> ValueType) -> ValueType {
    guard let associated = objc_getAssociatedObject(base, key) as? ValueType else {
        let associated = initializer()
        objc_setAssociatedObject(base, key, associated, .OBJC_ASSOCIATION_RETAIN)
        return associated
    }
    return associated
}

public func getOptionalAssociated<ValueType: AnyObject>(_ base: AnyObject, key: UnsafePointer<UInt8>, initializer: () -> ValueType?) -> ValueType? {
    guard let associated = objc_getAssociatedObject(base, key) as? ValueType else {
        let associated = initializer()
        if associated != nil {
            objc_setAssociatedObject(base, key, associated!, .OBJC_ASSOCIATION_RETAIN)
        }
        return associated
    }
    return associated
}

public func setAssociated<ValueType: AnyObject>(_ base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType){
    objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
}

public func setOptionalAssociated<ValueType: AnyObject>(_ base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType?){
    objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
}

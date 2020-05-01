//
//  ELog.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

final public class ELog {
    public class func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("🗣 [\(getCurrentTime())] EROOJA - \(output)", terminator: terminator)
        #else
            print("🗣 [\(getCurrentTime())] EROOJA - RELEASE MODE")
        #endif
    }
    
    public class func warning(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("⚡️ [\(getCurrentTime())] EROOJA - \(output)", terminator: terminator)
        #else
            print("⚡️ [\(getCurrentTime())] EROOJA - RELEASE MODE")
        #endif
    }
    
    public class func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("🚨 [\(getCurrentTime())] EROOJA - \(output)", terminator: terminator)
        #else
            print("🚨 [\(getCurrentTime())] EROOJA - RELEASE MODE")
        #endif
    }
    
    fileprivate class func getCurrentTime() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: now as Date)
    }

}

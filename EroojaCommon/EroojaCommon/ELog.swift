//
//  ELog.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

final public class ELog {
    public class func debug(message: String?) {
        print("🗣 [\(getCurrentTime())] \(String(describing: message))")
    }
    
    public class func warning(message: String?) {
        print("⚡️ [\(getCurrentTime())] \(String(describing: message))")
    }
    
    public class func error(message: String?) {
        print("🚨 [\(getCurrentTime())] \(String(describing: message))")
    }
    
    fileprivate class func getCurrentTime() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: now as Date)
    }
}

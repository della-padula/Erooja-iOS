//
//  APIResponseCode.swift
//  erooja
//
//  Created by denny.k on 2020/03/25.
//  Copyright © 2020 denny.k. All rights reserved.
//

import Foundation

// API Response Code (OUTLINE)
public struct APIResponseCode {
    static var SUCCESS: Int {
        return 0x2000
    }
    
    static var INVALID_PASSWORD: Int {
        return 0x4001
    }
    
    static var INVALID_ACCOUNT_ID: Int {
        return 0x4002
    }
    
}

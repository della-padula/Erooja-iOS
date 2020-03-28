//
//  EURLConstant.swift
//  EroojaNetwork
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct EURLConstant {
    fileprivate static let debugHostURL = "https://debug.com"
    
    fileprivate static let releaseHostURL = "https://release.com"
    
    public static var hostURL: String {
        #if DEBUG
        return debugHostURL
        #else
        return releaseHostURL
        #endif
    }
}

//
//  EURLConstant.swift
//  EroojaNetwork
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct EURLConstant {
    fileprivate static let debugHostURL = "http://www.siotman.com:20000/api/v1/"
    
    fileprivate static let releaseHostURL = "http://www.siotman.com:20000/api/v1/"
    
    public static var hostURLString : String {
        #if DEBUG
        return debugHostURL
        #else
        return releaseHostURL
        #endif
    }
    
    public static var hostURL : URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        
        #if DEBUG
        urlComponents.host = "www.siotman.com:20000/api/v1/"
        #else
        urlComponents.host = "www.siotman.com:20000/api/v1/"
        #endif
        
        return urlComponents.url
    }
}

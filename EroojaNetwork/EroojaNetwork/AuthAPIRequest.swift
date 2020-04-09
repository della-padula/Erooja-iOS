//
//  AuthAPIRequest.swift
//  EroojaNetwork
//
//  Created by 김태인 on 2020/04/09.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct AuthAPIRequest {
    enum RequestType {
        case kakaoToken(KakaoTokenReqType)
        case login
        case refreshToken
        
        
        var requestURL: URL{
            let compositeRequestURL: URL
            let baseContactsURL = URL(string: EURLConstant.hostURLString)!
            switch self {
            case let .kakaoToken(type):
                compositeRequestURL = baseContactsURL.appendingPathComponent("auth").appendingPathComponent("kakao")
                if type == .id {
                    compositeRequestURL.appendingPathComponent("")
                } else {
                    
                }
                break
            default:
                break
            }
        }
        
        var requestParameter: [String: Any] {
            var parameters: [String: Any] = [:]
            switch self {
            case let .kakaoToken(type):
                if type == .id {
                    parameters["by"] = "ID"
                } else {
                    parameters["by"] = "ACCESS_TOKEN"
                }
            default:
                break
            }
        }
    }
}

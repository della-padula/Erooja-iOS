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
        case kakaoToken(KakaoTokenReqType, String)
        case login
        case refreshToken
        
        
        var requestURL: URL{
            let compositeRequestURL: URL
            let baseURL = URL(string: EURLConstant.hostURLString)!
            switch self {
            case let .kakaoToken(type, _):
                let tempRequestURL = baseURL.appendingPathComponent("auth").appendingPathComponent("kakao")
                if type == .id {
                    compositeRequestURL = tempRequestURL.appendingPathComponent("?by=ID")
                } else {
                    compositeRequestURL = tempRequestURL.appendingPathComponent("?by=ACCESS_TOKEN")
                }
            case .login:
                // MARK: TEMP (Need to be updated)
                compositeRequestURL = baseURL
            case .refreshToken:
                compositeRequestURL = baseURL.appendingPathComponent("token").appendingPathComponent("refresh")
            }
            return compositeRequestURL
        }
        
        var requestParameter: [String: Any] {
            var parameters: [String: Any] = [:]
            switch self {
            case let .kakaoToken(type, value):
                if type == .id {
                    parameters["kakaoId"] = value
                } else {
                    parameters["accessToken"] = value
                }
            default:
                break
            }
            return parameters
        }
    }
}

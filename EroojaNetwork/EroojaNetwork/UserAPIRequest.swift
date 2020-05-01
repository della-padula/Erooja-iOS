//
//  UserAPIRequest.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct UserAPIRequest {
    enum RequestType {
        case nicknameExist(String)
        case nicknameUpdate(String)
        case getUserFromToken
        case userUpdate(String, String)
        case profileImageUpdate
        case getProfileImageHistory
        
        case getJobInterestList
        case addJobInterestList([Int])
        case addJobInterestItem(Int)
        
        
        var requestURL: URL{
            let compositeRequestURL: URL
            let baseURL = URL(string: EURLConstant.hostURLString)!.appendingPathComponent("member")
            switch self {
            // /api/v1/member/nickname/duplicity
            case .nicknameExist:
                compositeRequestURL = baseURL.appendingPathComponent("nickname").appendingPathComponent("duplicity")
            case .nicknameUpdate:
                compositeRequestURL = baseURL.appendingPathComponent("nickname")
            case .getUserFromToken, .userUpdate:
                compositeRequestURL = baseURL
            case .profileImageUpdate:
                compositeRequestURL = baseURL.appendingPathComponent("image")
            case .getProfileImageHistory:
                compositeRequestURL = baseURL.appendingPathComponent("images")
            case .getJobInterestList, .addJobInterestList:
                compositeRequestURL = baseURL.appendingPathComponent("jobInterests")
            case .addJobInterestItem:
                compositeRequestURL = baseURL.appendingPathComponent("jobInterest")
            }
            return compositeRequestURL
        }
        
        var requestParameter: [String: Any] {
            var parameters: [String: Any] = [:]
            switch self {
            case let .nicknameExist(value):
                parameters["nickname"] = value
            case let .nicknameUpdate(value):
                parameters["nickname"] = value
            case let.userUpdate(nickname, imageURL):
                parameters["nickname"] = nickname
                parameters["imagePath"] = imageURL
            case let.addJobInterestList(ids):
                parameters["ids"] = ids
            case let.addJobInterestItem(id):
                parameters["id"] = id
            default:
                break
            }
            return parameters
        }
    }
}

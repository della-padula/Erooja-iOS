//
//  GoalAPIRequest.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct GoalAPIRequest {
    enum RequestType {
        // goalFilterBy (String), keyword (String), fromDt (String), toDt (String), jobInterestIds ([Int])
        // goalSortBy (String), direction (String), size (Int), page (Int)
        case searchGoal(String, String, String, String, [Int], String, String, Int, Int)
        
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
            let baseURL = URL(string: EroojaURLConstant.hostURLString)!.appendingPathComponent("member")
            switch self {
            case .searchGoal(goalFilterBy, keyword, fromDt, toDt, jobInterestIds, goalSortBy, direction, size, page):
                
                break
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
        
        var requestParameter: [String: String] {
            var parameters: [String: String] = [:]
            switch self {
            case let .nicknameExist(value):
                parameters["nickname"] = value
            case let .nicknameUpdate(value):
                parameters["nickname"] = value
            case let.userUpdate(nickname, imageURL):
                parameters["nickname"] = nickname
                parameters["imagePath"] = imageURL
            case let.addJobInterestList(ids):
                var idsString = "["
                for (index, id) in ids.enumerated() {
                    idsString += "\(id)"
                    if index < ids.count - 1 {
                        idsString += ", "
                    }
                }
                idsString += "]"
                parameters["ids"] = idsString
            case let.addJobInterestItem(id):
                parameters["id"] = "\(id)"
            default:
                break
            }
            return parameters
        }
    }
}

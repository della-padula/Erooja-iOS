//
//  GoalAPIRequest.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public struct GoalSearchModel {
    public var goalFilterBy: String
    public var keyword: String
    public var fromDt: String
    public var toDt: String
    public var jobInterestIds: [Int]
    public var goalSortBy: String
    public var direction: String
    public var size: Int
    public var page: Int
    
    public init(goalFilterBy: String, keyword: String, fromDt: String, toDt: String,
                jobInterestIds: [Int], goalSortBy: String,
                direction: String, size: Int, page: Int) {
        self.goalFilterBy = goalFilterBy
        self.keyword = keyword
        self.fromDt = fromDt
        self.toDt = toDt
        self.jobInterestIds = jobInterestIds
        self.goalSortBy = goalSortBy
        self.direction = direction
        self.size = size
        self.page = page
    }
}

public struct GoalAPIRequest {
    enum RequestType {
        // goalFilterBy (String), keyword (String), fromDt (String), toDt (String), jobInterestIds ([Int])
        // goalSortBy (String), direction (String), size (Int), page (Int)
        case searchGoal(String, String, String, String, [Int], String, String, Int, Int)
        case createGoal
        case searchGoalByInterestId(String)
        case searchGoalByGoalID(String)
        
        case searchMemberListByGoalId(String, String, String)
        case searchGoalListByUserId(String, Int, Int, String, String, Bool)
        
        var requestURL: URL{
            let compositeRequestURL: URL
            switch self {
            case let .searchGoal(goalFilterBy, keyword, fromDt, toDt, jobInterestIds, goalSortBy, direction, size, page):
                var jobInterestIdString = ""
                for (index, interest) in jobInterestIds.enumerated() {
                    jobInterestIdString += "\(interest)"
                    if index < jobInterestIds.count - 1 {
                        jobInterestIdString += ","
                    }
                }
                
                let queryItems = [URLQueryItem(name: "goalFilterBy", value: goalFilterBy),
                                  URLQueryItem(name: "keyword", value: keyword),
                                  URLQueryItem(name: "fromDt", value: fromDt),
                                  URLQueryItem(name: "toDt", value: toDt),
                                  URLQueryItem(name: "jobInterestIds", value: jobInterestIdString),
                                  URLQueryItem(name: "goalSortBy", value: goalSortBy),
                                  URLQueryItem(name: "direction", value: direction),
                                  URLQueryItem(name: "size", value: "\(size)"),
                                  URLQueryItem(name: "page", value: "\(page)")]
                
                var urlComps = URLComponents(string: "\(EroojaURLConstant.hostURLString)goal")!
                urlComps.queryItems = queryItems
                
                let result = urlComps.url!
                ELog.debug(result)
                compositeRequestURL = result
            case let .searchGoalListByUserId(uid, size, page, sortBy, direction, endDtIsBeforeNow):
                let queryItems = [URLQueryItem(name: "uid", value: uid),
                                  URLQueryItem(name: "size", value: "\(size)"),
                                  URLQueryItem(name: "page", value: "\(page)"),
                                  URLQueryItem(name: "sortBy", value: sortBy),
                                  URLQueryItem(name: "direction", value: direction),
                                  URLQueryItem(name: "endDtIsBeforeNow", value: endDtIsBeforeNow ? "true" : "false")]
                
                var urlComps = URLComponents(string: "\(EroojaURLConstant.hostURLString)membergoal")!
                urlComps.queryItems = queryItems
                
                let result = urlComps.url!
                ELog.debug(result)
                compositeRequestURL = result
                break
            case let .searchGoalByInterestId(interestId):
                compositeRequestURL = URL(string: EroojaURLConstant.hostURLString)!.appendingPathComponent("goal/interest/\(interestId)")
            case .createGoal:
                compositeRequestURL = URL(string: EroojaURLConstant.hostURLString)!.appendingPathComponent("goal")
            case let .searchGoalByGoalID(id):
                compositeRequestURL = URL(string: EroojaURLConstant.hostURLString)!.appendingPathComponent("goal/\(id)")
            case let .searchMemberListByGoalId(id, size, page):
                let queryItems = [ URLQueryItem(name: "size", value: "\(size)"),
                                   URLQueryItem(name: "page", value: "\(page)") ]
                
                var urlComps = URLComponents(string: "\(EroojaURLConstant.hostURLString)membergoal/\(id)")!
                urlComps.queryItems = queryItems
                
                let result = urlComps.url!
                compositeRequestURL = result
            }
            return compositeRequestURL
        }
        
        var requestParameter: [String: String] {
            var parameters: [String: String] = [:]
            switch self {
            default:
                break
            }
            return parameters
        }
    }
}

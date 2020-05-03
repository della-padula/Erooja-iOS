//
//  EroojaAPIRequest+Goal.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 Denny.K. All rights reserved.
//

import Foundation
import Alamofire
import EroojaCommon

// Create Goal
public struct GoalCreateRequestModel: Codable {
    var title: String
    var description: String
    var isDateFixed: Bool
    var endDt: String
    var interestIdList: [Int]
    var todoList: [ToDoRequestModel]
    
    var dictionary: [String: Any] {
        return ["title": title,
                "description": description,
                "isDateFixed": isDateFixed,
                "endDt": endDt,
                "interestIdList": interestIdList,
                "todoList": todoList]
    }
    
    public init(title: String, description: String, isDateFixed: Bool, endDt: String, interestIdList: [Int], todoList: [ToDoRequestModel]) {
        self.title = title
        self.description = description
        self.isDateFixed = isDateFixed
        self.endDt = endDt
        self.interestIdList = interestIdList
        self.todoList = todoList
    }
}

public struct ToDoRequestModel: Codable {
    var content: String
    var priority: Int
    
    public init(content: String, priority: Int) {
        self.content = content
        self.priority = priority
    }
}

public extension EroojaAPIRequest {
    func requestSearchGoal(searchModel: GoalSearchModel, token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoal(searchModel.goalFilterBy, searchModel.keyword, searchModel.fromDt,
                                                              searchModel.toDt, searchModel.jobInterestIds, searchModel.goalSortBy,
                                                              searchModel.direction, searchModel.size, searchModel.page).requestURL
        
        ELog.debug("urlString : \(urlString)")
        
        AF.request(urlString, method: .get).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
    
    func requestCreateGoal(createGoalModel: GoalCreateRequestModel, token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.createGoal.requestURL
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(urlString, method: .post, parameters: createGoalModel, encoder: JSONParameterEncoder.default, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
    
    func requestSearchGoalByID(goalId: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoalByGoalID(goalId).requestURL
        AF.request(urlString).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
    
    func requestSearchGoalByInterest(interestId: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoalByInterestId(interestId).requestURL
        AF.request(urlString).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
    
    func requestMemberListByGoalId(goalId: Int, size: Int, page: Int, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchMemberListByGoalId("\(goalId)", "\(size)", "\(page)").requestURL
        AF.request(urlString).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
    
    func requestGoalListByUserId(userId: String, size: Int, page: Int, sortBy: String,
                                 direction: String, endDtIsBeforeNow: Bool,
                                 completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoalListByUserId(userId, size, page, sortBy,
                                                                          direction, endDtIsBeforeNow).requestURL
        AF.request(urlString, method: .get).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                ELog.error(error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
}

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
}

public struct ToDoRequestModel: Codable {
    var content: String
    var priority: Int
}

public extension EroojaAPIRequest {
    func requestSearchGoal(searchModel: GoalSearchModel, token: String, completion: @escaping (Result<Bool, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoal(searchModel.goalFilterBy, searchModel.keyword, searchModel.fromDt,
                                                              searchModel.toDt, searchModel.jobInterestIds, searchModel.goalSortBy,
                                                              searchModel.direction, searchModel.size, searchModel.page).requestURL
        ELog.debug("urlString : \(urlString)")
    }
    
    func requestCreateGoal(createGoalModel: GoalCreateRequestModel?, token: String?, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.createGoal.requestURL
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        let aa = GoalCreateRequestModel(title: "TestTest", description: "DesDes", isDateFixed: true, endDt: "2020-05-20T00:00:00", interestIdList: [1, 4, 6, 8], todoList: [ToDoRequestModel(content: "TODO1", priority: 0), ToDoRequestModel(content: "TODO2", priority: 1)])
        let parameters = aa.dictionary
        
        ELog.debug("parameters : \(parameters)")
        
        AF.request(urlString, method: .post, parameters: createGoalModel!, encoder: JSONParameterEncoder.default, headers: headers).responseJSON(completionHandler: { response in
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

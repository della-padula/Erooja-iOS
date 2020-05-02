//
//  EroojaAPIRequest+Job.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 Denny.K. All rights reserved.
//

import Foundation
import Alamofire
import EroojaCommon

public extension EroojaAPIRequest {
    func fetchJobGroupList(token: String, completion: @escaping (Result<Any, EroojaAPIError>) -> Void) {
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        let urlString = JobAPIRequest.RequestType.fetchJobGroupList.requestURL
        
        AF.request(urlString, method: .get, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value) {
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
    
    func fetchJobListByJobGroup(jobGroupId: Int, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = JobAPIRequest.RequestType.fetchJobListFromGroupId(jobGroupId).requestURL
        
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
    
    func fetchJobItemFromId(jobItemId: Int, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = JobAPIRequest.RequestType.fetchJobFromItemId(jobItemId).requestURL
        
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

//
//  EroojaAPIRequest.swift
//  erooja
//
//  Created by denny.k on 2020/03/28.
//  Copyright © 2020 denny.k. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger
import EroojaCommon

public class EroojaAPIRequest {
    public init() {
        #if DEBUG
            NetworkActivityLogger.shared.level = .debug
            NetworkActivityLogger.shared.startLogging()
        #endif
    }
    
    public func requestTokenByKakao(id: String?, accessToken: String?, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        if (id == nil && accessToken == nil) || (id != nil && accessToken != nil) {
            completion(.failure(.invalidParameter))
        }
        
        let url = (id != nil) ? AuthAPIRequest.RequestType.kakaoToken(.id, id!)
                              : AuthAPIRequest.RequestType.kakaoToken(.token, accessToken!)
        
        let parameters = (id != nil) ? AuthAPIRequest.RequestType.kakaoToken(.id, id!).requestParameter
                                     : AuthAPIRequest.RequestType.kakaoToken(.token, accessToken!).requestParameter
        
        let urlString = url.requestURL.absoluteString.replacingOccurrences(of: "%3F", with: "?")
        ELog.debug("[EroojaAPIRequest] - Request URL : \(urlString)")
        ELog.debug("[EroojaAPIRequest] - Request Parameters : \(parameters)")
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseJSON(completionHandler: { response in
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
    
    public func refreshAccessToken(token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        let urlString = AuthAPIRequest.RequestType.refreshToken.requestURL
        
        AF.request(urlString, method: .get, headers: headers).responseJSON(completionHandler: { response in
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
    
    public func requestNicknameExist(nickname: String, token: String, completion: @escaping (Result<Bool, EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.nicknameExist(nickname).requestURL.absoluteString
        let parameters = UserAPIRequest.RequestType.nicknameExist(nickname).requestParameter
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseString(completionHandler: { response in
            switch response.result {
            case .success(_):
                ELog.debug("[EroojaAPIRequest]: Check Nickname Exist ")
                ELog.debug(response.value!)
                if response.value == "false" {
                    completion(.success(false))
                } else if response.value == "true" {
                    completion(.success(true))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(let _):
                completion(.failure(.urlRequestError))
            }
        })
    }
}

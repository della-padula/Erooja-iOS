//
//  EroojaAPIRequest+User.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import Alamofire

public extension EroojaAPIRequest {
    func requestNicknameExist(nickname: String, token: String, completion: @escaping (Result<Bool, EroojaAPIError>) -> Void) {
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
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
    
    func requestNicknameUpdate(nickname: String, token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.nicknameUpdate(nickname).requestURL.absoluteString
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        let parameters = UserAPIRequest.RequestType.nicknameUpdate(nickname).requestParameter
        
        AF.request(urlString, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
    
    func requestUploadImage(imageData: Data, token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.profileImageUpdate.requestURL
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)", "Content-Type":"multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "multipartImageFile", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: urlString, method: .put, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
    
    func requestGetUserInfo(token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.getUserFromToken.requestURL
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(urlString, method: .get, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
    
    func requestUpdateUserInfo(nickname: String, imageURL: String, token: String, completion: @escaping (Result<NSDictionary, EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.userUpdate(nickname, imageURL).requestURL
        let parameters = UserAPIRequest.RequestType.userUpdate(nickname, imageURL).requestParameter
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? NSDictionary) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
    
    func requestProfileImageHistory(token: String, completion: @escaping (Result<[String], EroojaAPIError>) -> Void) {
        let urlString = UserAPIRequest.RequestType.getProfileImageHistory.requestURL
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(urlString, method: .get, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let responseValue = (response.value as? [String]) {
                    completion(.success(responseValue))
                } else {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.urlRequestError))
            }
        })
    }
}

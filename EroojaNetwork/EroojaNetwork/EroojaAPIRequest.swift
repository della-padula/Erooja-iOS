//
//  EroojaAPIRequest.swift
//  erooja
//
//  Created by denny.k on 2020/03/28.
//  Copyright © 2020 denny.k. All rights reserved.
//

import Foundation
import Alamofire
import EroojaCommon

public enum KakaoTokenReqType {
    case id
    case token
}

public enum EroojaAPIError: Error {
    case basicAPIError(BasicAPIError)
    case unknown
    case urlRequestError
    case fileURLError
    case clientError
    case tokenExpired(String)
    
    case onFetchingError
    
    public var errorMessage: String? {
        let message: String?
        switch self {
        case let .basicAPIError(error):
            let errorCode = error.errorCode
            if errorCode == .notConnectedToInternet || errorCode == .timedOut || errorCode == .cannotConnectToHost {
                message = "Network_ErrorMessage"
            } else {
                message = error.message ?? "Network_ErrorMessage"
            }
        case .urlRequestError:
            // Debug용인 경우
            #if !REAL
            message = "URL 요청 주소 nil 에러"
            #else
            message = nil
            #endif
        case .clientError:
            message = "Gallery_Warning_Message_UnknownError"
        case .onFetchingError:
            message = "already fetching.."
        case let .tokenExpired(errorMessage):
            message = errorMessage
        default:
            message = nil
        }
        return message
    }
    
    public var isTokenExpired: Bool {
        if case .tokenExpired = self {
            return true
        }
        return false
    }
    
    public var isNetworkConnectionError: Bool {
        if case let .basicAPIError(basicAPIError) = self {
            let errorCode = basicAPIError.errorCode
            if errorCode == .unauthorizedNetwork || errorCode == .notConnectedToInternet || errorCode == .timedOut || errorCode == .cannotConnectToHost {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    public var isServerError: Bool {
        if case let .basicAPIError(basicAPIError) = self {
            return basicAPIError.isServerError
        } else {
            return false
        }
    }
    
    public var isNotExist: Bool {
        if let statusCode = statusCode {
            return statusCode == 404
        } else {
            return false
        }
    }
    
    public var statusCode: Int? {
        if case let .basicAPIError(basicAPIError) = self, let statusCode = basicAPIError.statusCode {
            return statusCode
        } else {
            return nil
        }
    }
}

public class EroojaAPIRequest {
    func requestWithJSON(jsonData: [String: String], completion: @escaping (Result<[String : String], EroojaAPIError>) -> Void) {
        AF.request(AuthAPIRequest.RequestType.kakaoToken(.id, jsonData["kakaoId"]!).requestURL, method: .post, parameters: jsonData, encoder: JSONParameterEncoder.default).response(completionHandler: { response in
            switch response.result {
            case .success(_):
                completion(.success(["token":"sample"]))
                break
            case .failure(let error):
                ELog.error(message: error.localizedDescription)
                completion(.failure(.urlRequestError)) // TEMP Error
            }
        })
    }
}

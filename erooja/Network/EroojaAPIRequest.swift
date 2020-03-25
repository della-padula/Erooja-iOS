//
//  EroojaAPIRequest.swift
//  erooja
//
//  Created by 김태인 on 2020/03/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

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
    
    public var onlyDebugMessage: Bool {
        switch self {
        case .onFetchingError:
            return true
        default:
            return false
        }
    }
    
    public func handleErrorProcess(ignoreAlert: Bool) {
        if let message = errorMessage {
            if onlyDebugMessage == true || ignoreAlert == true {
                print(message)
            } else {
                let alert = AlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(AlertAction(title: "Common_String_Confirm".localizedDrawer, style: .default))
                alert.show()
            }
        }
        if case .tokenExpired = self {
            DrawerProperty.provider.requestKnock()
        }
    }
    
    public func handleErrorProcess() {
        self.handleErrorProcess(ignoreAlert: false)
    }
    
    private struct DrawerErrorReason: Codable {
        struct DetailReason: Codable {
            let detailCode: Int
        }
        
        let code: Int
        let message: String
        let reason: DetailReason
        
        var isTokenExpired: Bool {
            return reason.detailCode == 9503
        }
    }
    
    public init(error: Error?) {
        if let talkAPIError = error as? TalkAPIError {
            if talkAPIError.statusCode == 401,
                let reason: DrawerErrorReason = talkAPIError.rawData?.mapping(),
                let errorMessage = talkAPIError.message,
                reason.isTokenExpired == true {
                self = .tokenExpired(errorMessage)
            } else {
                self = .talkAPIError(talkAPIError)
            }
        } else {
            self = .unknown
        }
    }
    
    public var isTokenExpired: Bool {
        if case .tokenExpired = self {
            return true
        }
        return false
    }
    
    public var isNetworkConnectionError: Bool {
        if case let .talkAPIError(talkAPIError) = self {
            let errorCode = talkAPIError.errorCode
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
        if case let .talkAPIError(talkAPIError) = self {
            return talkAPIError.isServerError
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
        if case let .talkAPIError(talkAPIError) = self, let statusCode = talkAPIError.statusCode {
            return statusCode
        } else {
            return nil
        }
    }
}

public class EroojaAPIRequest {
    
}

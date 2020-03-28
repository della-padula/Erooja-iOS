//
//  BasicAPIError.swift
//  EroojaNetwork
//
//  Created by denny.k on 2020/03/28.
//  Copyright © 2020 denny.k. All rights reserved.
//

import Foundation
import Alamofire

public enum BasicAPICommonStatusCode: Int {
    case success = 0
    case invalidUser = -1
    case noSuchChatRoom = -401
    case forbidden = -403
    case notFound = -404
    case cannotWriteToChatRoom = -402
    case unknownError = -500
    case notImplemented = -501
    case maintenance = -503
    case tokenExpired = -950
    case needToReauthenticate = -993
    case changeAccount = -995
    case abnormalNetwork = -996
    case banned = -997
    case needToReregister = -998
    case needToUpdateApplication = -999
    case cannotChangeUUID = -1001
    case noSuchUser = -1002
    case needParentalConsent = -1013
    case serviceUnderMaintenance = -9797
}

public struct BasicAPIError: Error {
    public enum ErrorCode: Int {
        case cancelled = -9999
        case badResponse = -1
        case serverError = -2
        case urlError = -3
        case unauthorizedNetwork = -4
        case notConnectedToInternet = -5
        case cannotConnectToHost = -6
        case timedOut = -7

        case badRequest = 400
        case unauthorized = 401
        
        var isServerError: Bool {
            switch self {
            case .serverError:
                return true
            default:
                return false
            }
        }
    }
    
    public var title: String?
    public var message: String?
    public let errorCode: ErrorCode
    public var code: BasicAPICommonStatusCode?
    public var rawCode: Int?
    public var urlString: String?
    public var urlLabel: String?
    
    public var statusCode: Int? // HTTP response code
    public var internalErrorCode: Int? // Any additional error code for general use
    
    public var rawError: Error?
    public var rawData: [AnyHashable: Any]?
    
    var token: String?
    var userInfo: [String: Any]?
    
    public static let badRequestError: BasicAPIError = BasicAPIError(errorCode: .badRequest)
    public static let badResponseError: BasicAPIError = BasicAPIError(errorCode: .badResponse)
    public static let unauthorizedNetworkError: BasicAPIError = BasicAPIError(errorCode: .unauthorizedNetwork)
    public static let notConnectedToInternetError: BasicAPIError = BasicAPIError(errorCode: .notConnectedToInternet)
    public static let cancelledError: BasicAPIError = BasicAPIError(errorCode: .cancelled)
    
    init(errorCode: ErrorCode, isSSLTrouble: Bool = false) {
        self.errorCode = errorCode
        self.isSSLTrouble = isSSLTrouble
    }
    
    init?(error: Error?, data: [AnyHashable: Any]?) {
        var errorCode: ErrorCode = .serverError
        var isSSLTrouble = false
        var statusCode: Int?
        var underlyingMessage: String?
        if let error = error as? AFError {
            switch error {
            case .parameterEncodingFailed:
                errorCode = .badRequest
                underlyingMessage = error.errorDescription
            case .responseValidationFailed(let reason):
                if case .unacceptableStatusCode(let code) = reason {
                    statusCode = code
                    if let statusCode = ErrorCode(rawValue: code) {
                        errorCode = statusCode
                    }
                }
            default:
                break
            }
        }
        
        if let error = error as? URLError {
            switch error.code {
            case .secureConnectionFailed, .serverCertificateHasBadDate, .serverCertificateUntrusted, .serverCertificateHasUnknownRoot, .serverCertificateNotYetValid, .clientCertificateRejected, .clientCertificateRequired:
                isSSLTrouble = true
                
            case .notConnectedToInternet:
                errorCode = .notConnectedToInternet
            case .cannotConnectToHost:
                errorCode = .cannotConnectToHost
            case .timedOut:
                errorCode = .timedOut
            case .cancelled:
                errorCode = .cancelled
            default:
                break
            }
        } else if let error = error as NSError? {
            switch error.code {
            case -999:
                errorCode = .cancelled
            default:
                errorCode = .badRequest
            }
        }
        
        self.init(errorCode: errorCode, isSSLTrouble: isSSLTrouble)
        self.statusCode = statusCode
        
        if let data = data {
            if let code = data["status"] as? Int {
                self.code = BasicAPICommonStatusCode(rawValue: code)
                self.rawCode = code
            }
            
            if let token = data["token"] as? String {
                self.token = token
            }
            
            if let message = data["message"] as? String {
                self.message = message
            } else if let message = data["error_message"] as? String {
                self.message = message
            }
            
            if let code = self.code, case .maintenance = code, let message = data["maintenance_message"] as? String {
                self.message = message
            }
            
            urlLabel = data["errUrlLabel"] as? String
            urlString = data["errUrl"] as? String
        }
        
        if self.message == nil, let underlyingMessage = underlyingMessage {
            self.message = underlyingMessage
        }
        self.rawError = error
        self.rawData = data
    }
    
    public var isTokenExpired: Bool {
        if let code = code, code == .tokenExpired {
            return true
        }
        if case .unauthorized = errorCode {
            return true
        }
        return false
    }
    
    public var isServerError: Bool {
        if let statusCode = statusCode, statusCode >= 400, statusCode < 500 {
            return false
        }
        return errorCode.isServerError
    }
    
    var isTokenRefreshFailure: Bool {
        guard let code = code else { return false }
        switch code {
        case .needToReregister, .needToReauthenticate, .changeAccount:
            return true
        default:
            return false
        }
    }
    
    public let isSSLTrouble: Bool
    
    public var isCancelledError: Bool {
        return errorCode == .cancelled
    }
}

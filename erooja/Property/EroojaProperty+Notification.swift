//
//  EroojaNotification.swift
//  erooja
//
//  Created by 김태인 on 2020/05/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import NotificationCenter

private let eroojaNotificationCenterList = "NotificationCenterList"
private let eroojaNotificationCenterLastSeen = "NotificationCenterLastSeen"
private let eroojaNotificationSettings = "NotificationSettings"
private let eroojaSetUserIDFinished = "EroojaSetUserIDFinished"

private let eroojaUserID = "EroojaUserID"
private let eroojaAccessToken = "EroojaAccessToken"
private let eroojaRefreshToken = "EroojaRefreshToken"

extension EroojaProperty {
    static func setStoredUserID(userId: String) {
        UserDefaults.standard.set(userId, forKey: eroojaUserID)
        NotificationCenter.default.post(name: Notification.Name(rawValue: eroojaSetUserIDFinished), object: nil)
    }
    
    static func setAccessToken(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: eroojaAccessToken)
    }
    
    static func setRefreshToken(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: eroojaRefreshToken)
    }
    
    static func loadStoredUserID() -> String? {
        return UserDefaults.standard.string(forKey:eroojaUserID)
    }
    
    static func loadAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: eroojaAccessToken)
    }
    
    static func loadRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: eroojaRefreshToken)
    }
}

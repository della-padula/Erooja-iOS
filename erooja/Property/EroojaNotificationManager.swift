//
//  EroojaNotification.swift
//  erooja
//
//  Created by 김태인 on 2020/05/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

private let eroojaNotificationCenterList = "NotificationCenterList"
private let eroojaNotificationCenterLastSeen = "NotificationCenterLastSeen"
private let eroojaNotificationSettings = "NotificationSettings"
private let eroojaUserID = "EroojaUserID"

extension EroojaProperty {
    static func setStoredUserID(userId: String) {
        UserDefaults.standard.set(userId, forKey: eroojaUserID)
    }
    
    static func loadStoredUserID() -> String? {
        UserDefaults.standard.string(forKey:eroojaUserID)
    }
}

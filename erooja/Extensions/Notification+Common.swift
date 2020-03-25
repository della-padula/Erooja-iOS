//
//  Notification+Common.swift
//  erooja
//
//  Created by denny.k on 2020/03/26.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit

public extension Notification.Name {
    static let themeChangeNotification = Notification.Name("ThemeChangeNotification")
    static let themeDownloadProgressNotification = Notification.Name("ThemeDownloadProgressNotification")
    static let themeDownloadCompletedNotification = Notification.Name("ThemeDownloadCompletedNotification")
    
    static let fontDownloadProgressNotification = Notification.Name("FontDownloadProgressNotification")
    static let fontDownloadCompletedNotification = Notification.Name("FontDownloadCompletedNotification")
    
    static let spushCalendarSyncRequiredNotification = Notification.Name("SPushCalendarSyncRequiredNotification")
    static let calendarSyncFinished = Notification.Name("TalkCalendarSyncFinished")
    static let locoResponseNewMemberNotificationV2 = Notification.Name("LocoResponseNewMemberNotificationV2")
    static let locoResponseDeleteMemberNotificationV2 = Notification.Name("LocoResponseDeleteMemberNotificationV2")
    static let oauthTokenDidRefreshed = Notification.Name("OAuthTokenDidRefreshed")
    static let searchUIShouldClose = Notification.Name("SearchUIShouldClose")
    
    static let userInterfaceStyleDidChangeNotification = Notification.Name("userInterfaceStyleDidChangeNotification")
}

public extension NSNotification {
    @objc static let themeChangeNotification = Notification.Name.themeChangeNotification
    static let themeDownloadProgressNotification = Notification.Name.themeDownloadProgressNotification
    static let themeDownloadCompletedNotification = Notification.Name.themeDownloadCompletedNotification
    
    static let fontDownloadProgressNotification = Notification.Name.fontDownloadProgressNotification
    static let fontDownloadCompletedNotification = Notification.Name.fontDownloadCompletedNotification
    
    @objc static let spushCalendarSyncRequiredNotification = Notification.Name.spushCalendarSyncRequiredNotification
    @objc static let calendarSyncFinished = Notification.Name.calendarSyncFinished
    @objc static let userInterfaceStyleDidChangeNotification = Notification.Name.userInterfaceStyleDidChangeNotification
}

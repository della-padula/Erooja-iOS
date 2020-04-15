//
//  CreateGoalDynamicProperty.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public struct CreateGoalDynamicProperty {
    public static var goalName: String?
    public static var goalContent: String?
    public static var isModifyAvailable: Bool = true
    
    public static var startDateString: String?
    public static var endDateString: String?
    
    // TEMP
    // Goal Field
    
    // Detail Goal List
    public static var detailGoalList = [String]()
    
    public static func printPropertyInfo() {
        ELog.debug(message: "goalName : \(goalName ?? "nil")")
        ELog.debug(message: "goalContent : \(goalContent ?? "nil")")
        ELog.debug(message: "isModifyAvailable : \(isModifyAvailable)")
        ELog.debug(message: "startDateString : \(startDateString ?? "nil")")
        ELog.debug(message: "startDateString : \(startDateString ?? "nil")")
        
        ELog.debug(message: "detail Goal List -- count : \(detailGoalList.count)")
        for (index, detail) in detailGoalList.enumerated() {
            ELog.debug(message: "--> detail \(index) : \(detail)")
        }
    }
}

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
    public static var cellValid: [Bool] = [false, false, true, true, false]
    
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
        var debugStr = ""
        debugStr.append(contentsOf: "goalName : \(goalName ?? "nil")\n")
        debugStr.append(contentsOf: "goalContent : \(goalContent ?? "nil")\n")
        debugStr.append(contentsOf: "isModifyAvailable : \(isModifyAvailable)\n")
        debugStr.append(contentsOf: "startDateString : \(startDateString ?? "nil")\n")
        debugStr.append(contentsOf: "endDateString : \(endDateString ?? "nil")\n\n")
        
        debugStr.append(contentsOf: "detail Goal List -- count : \(detailGoalList.count)\n")
        for (index, detail) in detailGoalList.enumerated() {
            debugStr.append(contentsOf: "--> detail \(index) : \(detail)\n")
        }
        
        ELog.debug(message: debugStr)
    }
    
    public static func isCellActive(at: Int) -> Bool {
        return cellValid[at]
    }
}

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
    // 첫 번째 항목은 false로 추후 변경 필요
    public static var cellValid: [Bool] = [false, false, true, true, false]
    
    public static var goalName: String?
    public static var goalContent: String?
    public static var isModifyAvailable: Bool = true
    
    public static var startDateString: String?
    public static var endDateString: String?
    
    // TEMP
    // Goal Field
    public static var goalFieldList = [String]()
    
    // Detail Goal List
    public static var detailGoalList = [String]()
    
    public static func printPropertyInfo() {
        ELog.debug(getDebugPropertyInfo())
    }
    
    public static func getDebugPropertyInfo() -> String {
        var debugStr = ""
        debugStr.append(contentsOf: "Selected Field List -- count : \(goalFieldList.count)\n")
        for (index, field) in goalFieldList.enumerated() {
            debugStr.append(contentsOf: "--> field \(index) : \(field)\n")
        }
        
        debugStr.append(contentsOf: "\ngoalName : \(goalName ?? "nil")\n")
        debugStr.append(contentsOf: "goalContent : \(goalContent ?? "nil")\n")
        debugStr.append(contentsOf: "isModifyAvailable : \(isModifyAvailable)\n")
        debugStr.append(contentsOf: "startDateString : \(startDateString ?? "nil")\n")
        debugStr.append(contentsOf: "endDateString : \(endDateString ?? "nil")\n\n")
        
        debugStr.append(contentsOf: "detail Goal List -- count : \(detailGoalList.count)\n")
        for (index, detail) in detailGoalList.enumerated() {
            debugStr.append(contentsOf: "--> detail \(index) : \(detail)\n")
        }
        
        return debugStr
    }
    
    public static func isCellActive(at: Int) -> Bool {
        return cellValid[at]
    }
    
    public static func addFieldToGoal(field: String?) {
        guard let title = field else { return }
        
        for item in goalFieldList {
            if item == title {
                return
            }
        }
        goalFieldList.append(title)
    }
    
    public static func removeFieldFromGoal(field: String?) {
        guard let title = field else { return }
        
        for (index, item) in goalFieldList.enumerated() {
            if item == title {
                goalFieldList.remove(at: index)
            }
        }
    }
}

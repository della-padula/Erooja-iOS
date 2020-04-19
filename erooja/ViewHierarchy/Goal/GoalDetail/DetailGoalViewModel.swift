//
//  DetailGoalViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/19.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public struct ToDo {
    var isChecked: Bool
    var index: Int
    var title: String
}

public class DetailGoalViewModel {
    var todoItems = DataBinding([ToDo]())
    var percent = DataBinding(0)
    
    public init() {
        #if DEBUG
        for index in 0..<10 {
            let todo = ToDo(isChecked: false, index: index, title: "TEST TODO \(index)")
            addToDoItem(item: todo)
        }
        #endif
    }
    
    public func addToDoItem(item: ToDo) {
        todoItems.valueForBind.append(item)
        setPercentValue()
    }
    
    public func setCheckItem(index: Int, isChecked: Bool) {
        ELog.debug(message: "View Model setCheckItem --- Index : \(index), Is Checked : \(isChecked)")
        todoItems.valueForBind[index].isChecked = isChecked
        setPercentValue()
    }
    
    private func setPercentValue() {
        let totalItemCount = todoItems.valueForBind.count
        let checkedCount = todoItems.valueForBind.filter { $0.isChecked }.count
        
        percent.valueForBind = (checkedCount * 100) / totalItemCount
    }
}

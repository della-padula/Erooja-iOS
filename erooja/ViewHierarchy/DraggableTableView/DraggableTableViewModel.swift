//
//  DraggableTableViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class DraggableTableViewModel {
    var tableListItem = DataBinding([String]())
    
    func getTableViewData() {
        var tempList = [String]()
        for index in 0..<100 {
            tempList.append("Table Item - \(index)")
        }
        tableListItem.valueForBind = tempList
    }
}

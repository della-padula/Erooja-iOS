//
//  CreateGoalDetailViewModel.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public class CreateGoalDetailViewModel {
    var detailList = DataBinding([String]())
    
    func append(item: String) {
        detailList.valueForBind.append(item)
    }
    
    // MARK: Not Yet
    func change(forAt: Int, toAt: Int) {
        let forItem = detailList.valueForBind[forAt]
        let toItem = detailList.valueForBind[toAt]
        
        removeItem(at: forAt)
        detailList.valueForBind.insert(toItem, at: forAt)
        
        removeItem(at: toAt)
        detailList.valueForBind.insert(forItem, at: toAt)
    }
    
    func removeAll() {
        detailList.valueForBind.removeAll()
    }
    
    func removeItem(at index: Int) {
        detailList.valueForBind.remove(at: index)
    }
}

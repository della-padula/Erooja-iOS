//
//  SignUpDetailViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public class SignUpDetailViewModel {
    var selectedList = DataBinding([Bool](repeating: false, count: 9))
    
    func userTriggeredDatailItem(index: Int) {
        ELog.debug(message: "Selected : \(index)")
        ELog.debug(message: "Selected Value : \(self.selectedList.valueForBind[index])")
        self.selectedList.valueForBind[index] = !self.selectedList.valueForBind[index]
        ELog.debug(message: "(Changed) Selected Value : \(self.selectedList.valueForBind[index])")
    }
}

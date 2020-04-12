//
//  CreateGoalViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaNetwork
import EroojaSharedBase
import EroojaCommon

public class CreateGoalViewModel {
    var progressValue = DataBinding(0.0)
}

extension CreateGoalViewModel {
    func setProgressValue(value: Double) {
        progressValue.valueForBind = value
    }
}

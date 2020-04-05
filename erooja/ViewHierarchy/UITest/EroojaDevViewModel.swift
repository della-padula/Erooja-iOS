//
//  EroojaDevViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public enum EroojaType: String, CaseIterable {
    case onboard       = "온보딩"
    case signup        = "회원가입"
    case mypage        = "마이페이지"
    case main          = "메인"
    case nowGoal       = "진행중인 목표"
    case search        = "검색"
    case addGoal       = "목표 추가"
    case peopleProfile = "타 계정페이지"
    case guest         = "게스트 로직"
    case apiTest       = "Dev - API Test"
    case modalViewTest = "Dev - Modal View"
}

public class UITestViewModel {
    var menuItems = DataBinding([EroojaType]())
    
    func setDevMenuItemsToView() {
        ELog.debug(message: "ViewModel : setDevMenuItemsToView")
        menuItems.valueForBind = EroojaType.allCases
    }
}

//
//  JobModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public enum JobType {
    // MARK: To be modified
    public enum Develop: String, CaseIterable {
        case android = "안드로이드" // 안드로이드
        case ios     = "iOS"     // iOS
        case web     = "프론트엔드"     // 프론트엔드
        case backend = "백엔드" // 백엔드
        case deep    = "머신러닝"    // 머신러닝
        case dataS   = "데이터 사이언스"   // 데이터 사이언스
        case dataE   = "데이터 엔지니어"   // 데이터 엔지니어
        case game    = "게임/애니메이션"    // 게임/애니메이션
        case devops  = "DevOps"  // DevOps.
    }
    
    public enum Design: String, CaseIterable {
        case ux      = "UX 디자인"       // UX 디자인
        case ui      = "UI, GUI 디자인"  // UI, GUI 디자인
        case motion  = "영상, 모션 디자인" // 영상, 모션 디자인
        case edit    = "편집 디자인"      // 편집 디자인
        case bx      = "BX 디자인"       // BX 디자인
        case web     = "웹 디자인"        // 웹 디자인
        case mobile  = "모바일 디자인"     // 모바일 디자인
        case graphic = "그래픽 디자인"     // 그래픽 디자인
        case package = "패키지 디자인"     // 패키지 디자인
    }
}

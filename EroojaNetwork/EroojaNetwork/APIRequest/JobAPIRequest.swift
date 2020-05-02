//
//  GoalAPIRequest.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public struct JobAPIRequest {
    enum RequestType {
        // 직군 불러오기
        case fetchJobGroupList
        // 직군, 직무 함께 조회
        case fetchJobListFromGroupId(String)
        // 직군,직무 단일 조회
        case fetchJobFromItemId(String)
        
        var requestURL: URL{
            let compositeRequestURL: URL
            let baseURL = URL(string: EroojaURLConstant.hostURLString)!
            switch self {
            case .fetchJobGroupList:
                compositeRequestURL = baseURL.appendingPathComponent("jobGroup")
            case .fetchJobListFromGroupId(let value):
                compositeRequestURL = baseURL.appendingPathComponent("jobGroup/\(value)")
            case .fetchJobFromItemId(let value):
                compositeRequestURL = baseURL.appendingPathComponent("jobInterest/\(value)")
            }
            return compositeRequestURL
        }
    }
}

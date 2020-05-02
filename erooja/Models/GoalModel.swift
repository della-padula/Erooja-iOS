//
//  GoalModel.swift
//  erooja
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct GoalModel: Codable {
    var content: [GoalTypeModel]
}

public struct GoalTypeModel: Codable {
    var createDt: String
    var updateDt: String
    var id: Int
    var title: String
    var description: String
    var joinCount: Int
    var isEnd: Bool
    var isDateFixed: Bool
    var startDt: String
    var endDt: String
    var jobInterests: [JobInterestType]
}

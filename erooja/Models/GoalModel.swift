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
    var pageable: Pageable
    var last: Bool
    var totalPages: Int
    var totalElements: Int
    var size: Int
    var number: Int
    var numberOfElements: Int
    var sort: SortType
    var first: Bool
    var empty: Bool
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

public struct GoalSearchResponseModel: Codable {
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
}

public struct SortType: Codable {
    var sorted: Bool
    var unsorted: Bool
    var empty: Bool
}

public struct Pageable: Codable {
    var sort: SortType
    var offset: Int
    var pageNumber: Int
    var pageSize: Int
    var unpaged: Bool
    var paged: Bool
}

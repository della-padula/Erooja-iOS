//
//  JobTypeModel.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

// MARK: for "Job Type List"
public struct JobTypeModel : Codable {
    var id: Int
    var name: String
}

public struct JobGroup: Codable {
    var id: Int
    var name: String
    var jobInterests: [JobInterest]
}

public struct JobInterest: Codable {
    var id: Int
    var name: String
    var jobGroupId: Int
}

//public struct JobInterestType: Codable {
//    var uid: String
//    var name: String
//    var jobInterestType: String
//}

// MARK: - JobInterest
public struct JobInterestType: Codable {
    let id: Int
    let name: String
    let jobInterestType: JobInterestTypeVal
}

public enum JobInterestTypeVal: String, Codable {
    case jobGroup = "JOB_GROUP"
    case jobInterest = "JOB_INTEREST"
}

//
//  UserModel.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct UserModel: Codable {
    var uid: Int
    var nickname: String
    var imagePath: String
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

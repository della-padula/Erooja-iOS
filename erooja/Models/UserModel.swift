//
//  UserModel.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct UserModel: Codable {
    var uid: String
    var nickname: String
    var imagePath: String?
}

public struct MemberResponse: Codable {
    var members: [Member]
    var size: Int
    var totalPages: Int
    var totalElement: Int
}

public struct Member: Codable {
    var uid: String
    var nickname: String
    var imagePath: String?
    var jobInterests: [JobInterest]
}

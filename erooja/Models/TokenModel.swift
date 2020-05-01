//
//  TokenModel.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct TokenModel: Codable {
    var token: String
    var refreshToken: String
    var isAdditionalInfoNeeded: Bool
}

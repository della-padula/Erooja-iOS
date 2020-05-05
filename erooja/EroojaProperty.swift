//
//  EroojaProperty.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct EroojaProperty {
    public static var accessToken: String?
    public static var refreshToken: String?
    public static var userId: String? // e.g) KAKAO@00000
    public static var isAdditionalInfoNeeded: Bool?
}

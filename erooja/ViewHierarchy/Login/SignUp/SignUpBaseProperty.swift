//
//  SignUpBaseProperty.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct SignUpBaseProperty {
    public static var nickname: String?
    public static var fieldType: FieldType?
    public static var detailSelectedIndex: Int = -1
    public static var isReloadDetailCell: Bool = false
}

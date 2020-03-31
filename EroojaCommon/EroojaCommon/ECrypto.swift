//
//  ECrypto.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

struct ECryptoConfig {
    static let key = "abcdefghijklmnopqrstuvwxyz123456"
    
    // AES initialization vector from first 16 chars
    static let initialVector = "ABC1DEF2GHI3JKL4"
}

public class ECrypto {
    public class func encryptEData(_ str: String) -> String? {
        if !str.isEmpty {
            
            guard let encryptedString = AES256CBC.encryptString(str, password: ECryptoConfig.key) else {
                return nil
            }
            
            return encryptedString
        }
        return nil
    }
    
    public class func decryptEData(_ str: String) -> String? {
        if !str.isEmpty {
            let encryptedString = str.replacingOccurrences(of: ECryptoConfig.initialVector, with: "",
                                                           options: String.CompareOptions.literal, range: nil)
            
            guard let decryptedString = AES256CBC.decryptString(encryptedString, password: ECryptoConfig.key) else {
                return nil
            }
            
            return decryptedString
        }
        return nil
    }
}

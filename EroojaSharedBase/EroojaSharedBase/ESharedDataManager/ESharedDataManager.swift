//
//  EroojaSharedBase.swift
//  EroojaSharedBase
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public class ESharedDataManager {
    public static shared = EroojaSharedBase()
    private let userDefault = UserDefaults.init(suiteName: "EroojaSharedBase")
    private init() { }
    
    public func setSharedData(value: String, key: String, completion: @escaping ((Bool) -> Void) {
        let encryptedData = ECrypto.encryptEData(value)
        completion(true)
    }
    
    public func getSharedData(key: String, completion: @escaping ((Bool, String?) -> Void)) {
        if let data = userDefault?.string(forKey: key) {
            completion(true, ECrypto.decryptEData(data))
        } else {
            completion(false, nil)
        }
    }
    
}

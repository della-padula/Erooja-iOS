//
//  ViewController.swift
//  erooja
//
//  Created by denny.k on 2020/03/25.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import EroojaCommon

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let encrypted = ECrypto.encryptEData("Hello World") {
            ELog.debug(message: encrypted)
            
            if let decrypted = ECrypto.decryptEData(encrypted) {
                ELog.debug(message: decrypted)
            } else {
                ELog.error(message: "ERROR")
            }
        } else {
            ELog.error(message: "ERROR")
        }
    }


}


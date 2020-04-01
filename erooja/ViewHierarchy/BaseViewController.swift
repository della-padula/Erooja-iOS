//
//  BaseViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI

public class BaseViewController: UIViewController {
    
    public func showAlertWithNoAction(title: String?, message: String?, completion: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: { action in
            completion(action)
        })
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

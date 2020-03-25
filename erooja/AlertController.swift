//
//  AlertController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public enum AlertType {
    case yesNo(AlertActionYesNo)
    case okCancel(AlertActionOkCancel)
    case ok
    
    public enum AlertActionOkCancel {
        case ok
        case cancel
    }
    
    public enum AlertActionYesNo {
        case yes
        case no
    }
}

public class AlertController {
    
    func showAlert(viewController: UIViewController, title: String?, message: String?, completion: @escaping (AlertType) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let btnOK = UIAlertAction(title: "확인", style: .default) { (action) in
            completion(.ok)
        }
        alert.addAction(btnOK)
        viewController.present(alert, animated: false, completion: nil)
    }
    
    func showAlertOKCancel(viewController: UIViewController, title: String?, message: String?, completion: @escaping (AlertType) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "확인", style: .default) { (action) in
            completion(.okCancel(.ok))
        }
        
        let btnCancel = UIAlertAction(title: "취소", style: .default) { (action) in
            completion(.okCancel(.cancel))
        }
        
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        viewController.present(alert, animated: false, completion: nil)
    }
    
    func showAlertYesNo(viewController: UIViewController, title: String?, message: String?, completion: @escaping (AlertType) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnYes = UIAlertAction(title: "예", style: .default) { (action) in
            completion(.yesNo(.yes))
        }
        let btnNo = UIAlertAction(title: "아니요", style: .default) { (action) in
            completion(.yesNo(.no))
        }
        
        alert.addAction(btnYes)
        alert.addAction(btnNo)
        viewController.present(alert, animated: false, completion: nil)
    }
}

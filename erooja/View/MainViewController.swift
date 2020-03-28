//
//  ViewController.swift
//  erooja
//
//  Created by denny.k on 2020/03/25.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import EroojaNetwork
import EroojaCommon

class MainViewController: UIViewController {
    
    private let loginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layout()
        
        ELog.debug(message: EURLConstant.hostURL)
        
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
    
    @objc private func touchUpLoginButton(_ sender: UIButton) {
        guard let session = KOSession.shared() else {
            return
        }
        
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if error != nil || !session.isOpen() { return }
            KOSessionTask.userMeTask(completion: { (error, user) in
                ELog.debug(message: "email : \(user?.account?.email)")
                ELog.debug(message: "nickname : \(user?.account?.profile?.nickname)")
                
                guard let user = user,
                    let email = user.account?.email,
                    let nickname = user.account?.profile?.nickname else { return }
//                
//                ELog.debug(message: "email : \(email)")
//                ELog.debug(message: "nickname : \(nickname)")
            })
        }
    }
    
    private func layout() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(loginButton)
        
        loginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}


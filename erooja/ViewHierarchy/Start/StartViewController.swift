//
//  StartViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaUI
import EroojaCommon
import EroojaNetwork
import NotificationCenter

public enum AppStatus {
    case error
    case noConfig
    case noAccount
    case success
}

public class StartViewController: BaseViewController {
    
    private let logoView = UIImageView(image: .mainLogo)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadLogoView(completion: { isSuccess in
            if isSuccess {
                self.checkSignedStatus()
            } else {
                self.routeViewController(status: .error)
            }
        })
    }
    
    private func checkSignedStatus() {
        // TEST
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.checkIsAutoLoginAvailable()
        })
        
        NotificationCenter.default.addObserver(forName: Notification.Name(EroojaNotifications.EroojaAutoLoginAvailable),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
                                                ELog.debug("Notification Post - AutoLogin Avaialble")
                                                self?.routeViewController(status: .success)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(EroojaNotifications.EroojaAutoLoginUnAvailable),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
                                                ELog.debug("Notification Post - AutoLogin Unavaialble")
                                                self?.routeViewController(status: .noConfig)
        }
    }
    
    private func routeViewController(status: AppStatus) {
//        #if DEBUG
//        LoginSwitcher.updateRootVC(type: .uitest)
//        #else
        switch(status) {
        case .success:
            // Have Config, Have Account
            // MARK: TEMP
            LoginSwitcher.updateRootVC(type: .login)
        case .noConfig:
            LoginSwitcher.updateRootVC(type: .onboarding)
            break
        case .noAccount:
            LoginSwitcher.updateRootVC(type: .login)
            break
        case .error:
            // Error (Terminate)
            self.showAlertWithNoAction(title: nil, message: "App. 실행 중 오류가 발생하였습니다. 다시 시도해주세요.", completion: { _ in
                exit(0)
            })
        }
//        #endif
    }
    
    private func loadLogoView(completion: @escaping (Bool) -> Void) {
        self.view.addSubview(logoView)
        
        logoView.isHidden = true
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: 55/19).isActive = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.logoView.isHidden = false
            completion(true)
        })
    }
    
    private func checkIsAutoLoginAvailable() {
        if let userId = EroojaProperty.loadStoredUserID() {
            ELog.debug("Stored User ID : \(userId)")
            NotificationCenter.default.post(name: Notification.Name(rawValue: EroojaNotifications.EroojaAutoLoginAvailable), object: nil)
        } else {
            NotificationCenter.default.post(name: Notification.Name(rawValue: EroojaNotifications.EroojaAutoLoginUnAvailable), object: nil)
        }
    }
}

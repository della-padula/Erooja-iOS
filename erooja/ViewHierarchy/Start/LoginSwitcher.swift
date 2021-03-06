//
//  LoginSwitcher.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class LoginSwitcher {
    enum StartViewType {
        case login
        case onboarding
        case main
        case uitest
    }
    
    static func updateRootVC(type: StartViewType) {
        var rootVC : UIViewController?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch(type) {
        case .main:
            rootVC = MainViewController()
            appDelegate.window?.rootViewController = rootVC
        case .login:
            rootVC = LoginViewController()
            appDelegate.window?.rootViewController = rootVC
        case .onboarding:
            rootVC = OnboardViewController()
            appDelegate.window?.rootViewController = rootVC
        case .uitest:
            if let vc = UIStoryboard(name: "EroojaDev", bundle: nil).instantiateViewController(withIdentifier: "UITestHomeVC") as? UITestViewController {
                let viewModel = UITestViewModel()
                vc.viewModel = viewModel
//                appDelegate.window?.rootViewController = vc
                
                let nav = UINavigationController()
                nav.viewControllers = [vc]
                appDelegate.window?.rootViewController = nav
            }
            break
        }
        
//        let status = UserDefaults.standard.bool(forKey: UserDefaultKey.loginStatus)
//        var navigationVC : UINavigationController?
        
//        if(status == true) {
//            tabBar = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "MainTabView") as? UITabBarController
//            navigationVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "mainNavigation") as! NavigationViewController
            
//        } else {
//            rootVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginNavigation") as! NavigationViewController
            //rootVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginView") as! LoginViewController
//        }
        
//        if rootVC != nil {
//            appDelegate.window?.rootViewController = rootVC
//        } else {
//            appDelegate.window?.rootViewController = tabBar
//            appDelegate.window?.rootViewController = navigationVC
//        }
    }
}

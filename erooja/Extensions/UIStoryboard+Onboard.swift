//
//  UIStoryboard+Onboard.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public extension UIStoryboard {
    @objc
    class func onboardViewController() -> OnboardViewController? {
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OnboardViewController") as? OnboardViewController
    }
    
}

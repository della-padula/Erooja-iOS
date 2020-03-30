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
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OnboardViewController") as? OnboardViewController
    }
    
    @objc
    class func onboardingStageTwoViewController(firstAppeared: Bool) -> OnboardingStageTwoViewController? {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingStageTwoViewController") as? OnboardingStageTwoViewController
        return vc
    }

    @objc
    class func onboardingStageThreeViewController() -> OnboardingStageThreeViewController? {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OnboardingStageThreeViewController") as? OnboardingStageThreeViewController
    }
    
}

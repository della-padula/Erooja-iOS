//
//  EUINavigationController.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class EUINavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    public var isPortrait = false
    public var isPopGestureAllow = true
    public var onTransitionAnimating = false
    public var hasChildViewControllerPreferredStatusBarStyle = false
    var keyboardWillHide = false
    
    private var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

//
//  OnboardingStageTwoViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class OnboardingStageTwoViewController: UIViewController {
    
    @IBOutlet weak var devImageView: UIImageView!
    @IBOutlet weak var designImageView: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        devImageView.layer.cornerRadius = devImageView.bounds.width / 2
        
        designImageView.layer.cornerRadius = designImageView.bounds.width / 2
    }
}

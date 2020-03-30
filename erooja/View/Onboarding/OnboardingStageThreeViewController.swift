//
//  OnboardingStageThreeViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class OnboardingStageThreeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2 
    }
}

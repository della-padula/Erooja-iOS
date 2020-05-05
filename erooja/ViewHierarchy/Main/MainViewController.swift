//
//  MainViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class MainViewController: BaseViewController {
    @IBOutlet weak var navHeaderView: EUIHeaderView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        ELog.debug("Main View Controller - viewDidLoad()")
        configHeaderView()
    }
    
    private func configHeaderView() {
        navHeaderView.barOptions = [.rightFirstButton, .rightSecondButton]
        navHeaderView.setRightButtonImage(position: .first, image: .navNotification)
        navHeaderView.setRightButtonImage(position: .second, image: .navSearch)
    }
}

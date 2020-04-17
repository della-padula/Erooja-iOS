//
//  JobItemButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/17.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import UIKit

public class JobItemButton: UIView {
    
    public var isActive: Bool = false {
        didSet {
            self.setButtonStyle()
        }
    }
    
    private func setButtonStyle() {
        layer.cornerRadius = 4
        layer.borderColor = isActive ? EroojaColorSet.shared.orgDefault400s.cgColor : EroojaColorSet.shared.gray500s.cgColor
        layer.borderWidth = isActive ? 1.5 : 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}




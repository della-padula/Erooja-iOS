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
    
    private let button = UIButton()
    private let label = UILabel()
    
    public var title: String? {
        didSet {
            self.label.text = title
        }
    }
    
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
        
        addSubview(button)
        addSubview(label)
        
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc
    private func onClickButton(_ sender: UIButton) {
        ELog.debug(message: "Job Button Clicked - title : \(title ?? "nil")")
    }
}




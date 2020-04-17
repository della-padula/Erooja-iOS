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

public protocol JobItemButtonDelegate {
    func onClickButton(jobItemButton: JobItemButton, title: String?, isActive: Bool)
}

public class JobItemButton: UIView {
    
    private let button = UIButton()
    private let label = UILabel()
    
    public var delegate: JobItemButtonDelegate?
    
    public var title: String? {
        didSet {
            self.label.text = title
//            self.button.setTitle(title, for: .normal)
        }
    }
    
    public var isActive: Bool = false {
        didSet {
            self.setButtonStyle()
        }
    }
    
    private func setButtonStyle() {
        layer.cornerRadius = 8
        layer.borderColor = isActive ? EroojaColorSet.shared.orgDefault400s.cgColor : EroojaColorSet.shared.gray400s.cgColor
        layer.borderWidth = 1
        
        label.textColor = isActive ? EroojaColorSet.shared.orgDefault400s : EroojaColorSet.shared.gray400s
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButtonLayout()
    }
    
    private func setButtonLayout() {
        addSubview(button)
        addSubview(label)
        
        setButtonStyle()
        label.font = .SpoqaRegular15P
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 16).isActive = true
        button.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 16).isActive = true
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.textAlignment = .center
    }
    
    @objc
    private func onClickButton(_ sender: UIButton) {
        self.isActive = !isActive
        ELog.debug(message: "Job Button Clicked - title : \(title ?? "nil") / isActive : \(isActive)")
        delegate?.onClickButton(jobItemButton: self, title: title, isActive: isActive)
    }
}




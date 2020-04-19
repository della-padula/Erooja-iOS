//
//  EShadowRoundButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/19.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaCommon

public class EShadowRoundButton: UIView {
    private let button = UIButton()
    private let titleLabel = UILabel()
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            addShadowToView()
        }
    }
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var titleFont: UIFont? {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    public var shadowColor: UIColor? {
        didSet {
            addShadowToView()
        }
    }
    
    public var shadowWidth: CGFloat? {
        didSet {
            addShadowToView()
        }
    }
    
    public var shadowVerticalOffset: CGFloat? {
        didSet {
            addShadowToView()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setViewLayout()
    }
    
    fileprivate func setViewLayout() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        self.addSubview(button)
        
        titleLabel.textAlignment = .center
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        addShadowToView()
    }
    
    fileprivate func addShadowToView() {
        guard let shadowColor = shadowColor,
              let shadowWidth = shadowWidth,
              let shadowVerticalOffset = shadowVerticalOffset else {
            return
        }
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .init(width: 0, height: shadowVerticalOffset)
        self.layer.shadowRadius = shadowWidth
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        ELog.debug(message: "self.frame = \(self.frame)")
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height * 0.5
    }
}

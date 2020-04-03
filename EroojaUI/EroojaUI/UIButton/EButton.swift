//
//  EButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public class EButton: UIView {
    private var button     = UIButton()
    private var titleLabel = UILabel()
    private var imageView  = UIImageView()
    
    public init() {
        super.init(frame: .zero)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(button)
        setButtonLayout()
    }
    
    public var image: UIImage? {
        didSet {
            setButtonStyle()
        }
    }
    
    public var title: String? {
        didSet {
            setButtonStyle()
        }
    }
    
    public var textColor: UIColor? {
        didSet {
            titleLabel.textColor = textColor
        }
    }
    
    public var font: UIFont? {
        didSet {
            titleLabel.font = font
        }
    }
    
    public var padding: CGFloat = 0 {
        didSet {
            setButtonLayout()
        }
    }
    
    public func setButtonType(buttonType: ERightButton.ButtonType) {
        if buttonType == .image {
            imageView.isHidden = false
            titleLabel.isHidden = true
        } else {
            imageView.isHidden = true
            titleLabel.isHidden = false
        }
    }
    
    public func addTarget(target: Any?, action: Selector, forEvent: UIControl.Event) {
        button.addTarget(target, action: action, for: forEvent)
    }
    
    private func setButtonLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding).isActive = true
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setButtonStyle() {
        titleLabel.text = title
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

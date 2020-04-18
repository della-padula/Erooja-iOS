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
        titleLabel.textAlignment = .center
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(button)
        setButtonLayout()
    }
    
    public var activeColor: UIColor = EroojaColorSet.shared.gray700 {
        didSet {
            textColor = isActive ? activeColor : inActiveColor
            imageView.tintColor = isActive ? activeColor : inActiveColor
        }
    }
    public var inActiveColor: UIColor = EroojaColorSet.shared.gray400 {
        didSet {
            textColor = isActive ? activeColor : inActiveColor
            imageView.tintColor = isActive ? activeColor : inActiveColor
        }
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
    
    public var isActive: Bool = false {
        didSet {
            self.isUserInteractionEnabled = isActive
            textColor = isActive ? activeColor : inActiveColor
            imageView.tintColor = isActive ? activeColor : inActiveColor
        }
    }
    
    private var constraintList = [NSLayoutConstraint]()
    
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
    
        // Disable Constraint
        NSLayoutConstraint.deactivate(constraintList)
        
        constraintList.removeAll()
        
        constraintList.append(imageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        constraintList.append(imageView.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraintList.append(imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -(padding * 2)))
        constraintList.append(imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -(padding * 2)))
        
//        constraintList.append(imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding))
//        constraintList.append(imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding))
//        constraintList.append(imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding))
//        constraintList.append(imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding))
        
//        constraintList.append(titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding))
//        constraintList.append(titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding))
        constraintList.append(titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding))
        constraintList.append(titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding))
        constraintList.append(titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraintList.append(titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        
        constraintList.append(button.topAnchor.constraint(equalTo: topAnchor))
        constraintList.append(button.bottomAnchor.constraint(equalTo: bottomAnchor))
        constraintList.append(button.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraintList.append(button.trailingAnchor.constraint(equalTo: trailingAnchor))
        
        // Enable Constraint
        NSLayoutConstraint.activate(constraintList)
    }
    
    private func setButtonStyle() {
        titleLabel.text = title
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

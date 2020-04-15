//
//  ETabButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public protocol ETabButtonDelegate {
    func onClickButton(_ button: ETabButton, tag: Int)
}

public class ETabButton: UIView {
    
    private var button = UIButton()
    private var titleLabel = UILabel()
    private var bottomLine = UIView()
    
    public var delegate: ETabButtonDelegate?
    
    public var isActive: Bool = false {
        didSet {
            self.bottomLine.isHidden = !isActive
            self.titleLabel.textColor = isActive ? .black : EroojaColorSet.shared.gray300s
        }
    }
    
    public var title: String? {
        didSet {
            self.setTitle()
        }
    }
    
    public var barTintColor: UIColor? {
        didSet {
            bottomLine.backgroundColor = barTintColor
        }
    }
    
    public init(tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        setViewLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setTitle() {
        self.titleLabel.text = self.title
        self.titleLabel.font = .SpoqaBold14P
    }
    
    fileprivate func setViewLayout() {
        addSubview(button)
        button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: leadingAnchor)])
        NSLayoutConstraint.activate([button.trailingAnchor.constraint(equalTo: trailingAnchor)])
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: topAnchor)])
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bottomLine.bottomAnchor.constraint(equalTo: button.bottomAnchor)])
        NSLayoutConstraint.activate([bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor)])
        NSLayoutConstraint.activate([bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor)])
        NSLayoutConstraint.activate([bottomLine.heightAnchor.constraint(equalToConstant: 2)])
        
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)])
        NSLayoutConstraint.activate([titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor)])
        NSLayoutConstraint.activate([titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    @objc
    private func onClickButton() {
        delegate?.onClickButton(self, tag: self.tag)
    }
}

//
//  DetailGoalToDoItem.swift
//  erooja
//
//  Created by 김태인 on 2020/04/19.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class DetailGoalToDoItemView: UIView {
    private let textLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewLayout() {
        // MARK: For TEST
        textLabel.text = "TEST text"
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}

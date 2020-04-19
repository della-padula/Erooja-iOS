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

public protocol DetailGoalToDoItemDelegate {
    func onClickCheckButton(index: Int, isChecked: Bool)
}

public class DetailGoalToDoItemView: UIView {
    private let textLabel = UILabel()
    private let checkButtonImage = UIImageView()
    private let checkButton = UIButton()
    public var delegate: DetailGoalToDoItemDelegate?
    
    public var isChecked: Bool = false {
        didSet {
            setViewState(isChecked: isChecked)
        }
    }
    
    public var item: ToDo? {
        didSet {
            if let item = item {
                textLabel.text = item.title
                isChecked = item.isChecked
            }
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewLayout() {
        setCheckButton()
        setTitleLabel()
        self.backgroundColor = EroojaColorSet.shared.white100
        self.bounds.size.height = 44
    }
    
    private func setTitleLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: checkButtonImage.trailingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setCheckButton() {
        addSubview(checkButtonImage)
        addSubview(checkButton)
        
        checkButtonImage.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButtonImage.image = .checkButtonOff
        checkButtonImage.contentMode = .scaleAspectFit
        
        checkButtonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        checkButtonImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        checkButtonImage.heightAnchor.constraint(equalTo: checkButtonImage.widthAnchor).isActive = true
        checkButtonImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        checkButtonImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        checkButtonImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        checkButton.widthAnchor.constraint(equalTo: checkButtonImage.widthAnchor).isActive = true
        checkButton.heightAnchor.constraint(equalTo: checkButtonImage.heightAnchor).isActive = true
        checkButton.addTarget(self, action: #selector(onClickCheckButton(_:)), for: .touchUpInside)
    }
    
    private func setViewState(isChecked: Bool) {
        checkButtonImage.image = isChecked ? .checkButtonOn : .checkButtonOff
        textLabel.font = .SpoqaRegular15P
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item?.title ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        textLabel.textColor = isChecked ? EroojaColorSet.shared.gray400 : EroojaColorSet.shared.gray700
        
        if isChecked {
            textLabel.text = ""
            textLabel.attributedText = attributeString
        } else {
            textLabel.attributedText = .none
            textLabel.text = item?.title
        }
    }
    
    @objc
    private func onClickCheckButton(_ sender: UIButton) {
        guard let item = item else { return }
        delegate?.onClickCheckButton(index: item.index, isChecked: isChecked)
    }
}

//
//  SignUpFirstViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class SignUpViewCell: UICollectionViewCell {
    public enum SignUpType {
        case nickname
        case field
        case detail
    }
    
    private let lblTitle = UILabel()
    
    public var delegate: SignUpCellDelegate?
    
    public var viewModel: SignUpViewModel? {
        didSet {
            self.title = viewModel?.title
            self.viewType = viewModel?.type
        }
    }
    
    public var title: String? {
        didSet {
            self.lblTitle.text = title
        }
    }
    
    public var viewType: SignUpType? {
        didSet {
            setupDetailViewLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    
    private func setupCell() {
        self.lblTitle.text = self.title ?? "NO TITLE"
        self.lblTitle.font = .AppleSDBold20P
        self.lblTitle.textAlignment = .center
        self.lblTitle.textColor = EroojaColorSet.shared.gray100s
        self.addSubview(lblTitle)
        
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 88).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupDetailViewLayout() {
        if viewType == .nickname {
            let fieldView = UIView()
            let bottomBorderView = UIView()
            let textFieldView = EroojaTextField()
            let checkBadgeView = UIImageView()
            
            checkBadgeView.image = UIImage(named: "signup_check")
            checkBadgeView.isHidden = true
            
            fieldView.backgroundColor = .clear
            
            textFieldView.backgroundColor = .clear
            textFieldView.textAlignment = .center
            textFieldView.placeholder = "5자 이내 입력"
            textFieldView.debounce(delay: 0.3) { (text) in
                ELog.debug(message: "Debounce Text : \(text ?? "nil"), Length : \(text?.count ?? 0)")
                checkBadgeView.isHidden = (text ?? "").isEmpty
            }
            textFieldView.font = .AppleSDBold15P
            textFieldView.textColor = EroojaColorSet.shared.gray100s
            
            self.addSubview(fieldView)
            fieldView.addSubview(textFieldView)
            fieldView.addSubview(checkBadgeView)
            
            fieldView.translatesAutoresizingMaskIntoConstraints = false
            textFieldView.translatesAutoresizingMaskIntoConstraints = false
            checkBadgeView.translatesAutoresizingMaskIntoConstraints = false
            
            fieldView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            fieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            fieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive = true
            fieldView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 60).isActive = true
            
            textFieldView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
            textFieldView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
            textFieldView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
            textFieldView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
            
            checkBadgeView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
            checkBadgeView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
            checkBadgeView.widthAnchor.constraint(equalTo: checkBadgeView.heightAnchor).isActive = true
            checkBadgeView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
            
            bottomBorderView.backgroundColor = EroojaColorSet.shared.orgDefault400s
            self.addSubview(bottomBorderView)
            bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
            bottomBorderView.topAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
            bottomBorderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            bottomBorderView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
            bottomBorderView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

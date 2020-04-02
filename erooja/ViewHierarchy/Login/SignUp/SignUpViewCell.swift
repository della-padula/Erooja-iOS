//
//  SignUpFirstViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaUI
import EroojaCommon

public enum SignUpType {
    case nickname
    case field
    case detail
}

public enum FieldType {
    case development
    case design
}

public class SignUpViewCell: UICollectionViewCell {
    private var isNicknameValid: Bool = false
    private var isFieldValid: Bool = false
    private var isDetailValid: Bool = false
    
    private let lblTitle = UILabel()
    private let lblSubTitle = UILabel()
    
    private let fieldView = UIView()
    private let fieldDevelopmentView   = SignUpFieldButton()
    private let fieldDesignView   = SignUpFieldButton()
    
    private var fieldButtonModels = [Field(type: .development, title: "개발 직군", isActive: false, imageOn: .signup_field_dev_on, imageOff: .signup_field_dev_off), Field(type: .design,title: "디자인 직군", isActive: false, imageOn: .signup_field_design_on, imageOff: .signup_field_design_off)]
    
    private var fieldType: FieldType? {
        didSet {
            if fieldType == .development {
                fieldDevelopmentView.isActive = true
                fieldDesignView.isActive = false
                self.delegate?.setButtonStyle(forState: .active)
            } else if  fieldType == .design {
                fieldDevelopmentView.isActive = false
                fieldDesignView.isActive = true
                self.delegate?.setButtonStyle(forState: .active)
            } else {
                self.delegate?.setButtonStyle(forState: .inActive)
            }
        }
    }
    
    public var delegate: SignUpCellDelegate?
    
    public var viewModel: SignUpViewModel? {
        didSet {
            self.title = viewModel?.title
            self.subTitle = viewModel?.subTitle
            self.viewType = viewModel?.type
        }
    }
    
    public var title: String? {
        didSet {
            self.lblTitle.text = title
        }
    }
    
    public var subTitle: String? {
        didSet {
            self.lblSubTitle.text = subTitle
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
    
    // PUBLIC
    public func checkButtonState() {
        switch viewType {
        case .nickname:
            delegate?.setButtonStyle(forState: isNicknameValid ? .active : .inActive)
        case .field:
            delegate?.setButtonStyle(forState: isFieldValid ? .active : .inActive)
        case .detail:
            delegate?.setButtonStyle(forState: isDetailValid ? .active : .inActive)
        default:
            break
        }
    }
    
    private func setupCell() {
        self.lblTitle.text = self.title ?? "NO TITLE"
        self.lblTitle.font = .AppleSDBold20P
        self.lblTitle.textAlignment = .center
        self.lblTitle.textColor = EroojaColorSet.shared.gray100s
        self.addSubview(lblTitle)
        
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 44).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupDetailViewLayout() {
        switch viewType {
        case .nickname:
            setupNicknameView()
        case .field:
            setupFieldView()
        case .detail:
            setupDetailView()
        default:
            break
        }
    }
    
    private func setupDetailView() {
        self.lblSubTitle.text = self.subTitle ?? "NO TITLE"
        self.lblSubTitle.font = .AppleSDSemiBold15P
        self.lblSubTitle.textAlignment = .center
        self.lblSubTitle.textColor = EroojaColorSet.shared.gray300s
        self.addSubview(lblSubTitle)
        
        self.lblSubTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblSubTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        self.lblSubTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lblSubTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.lblSubTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let containerView = UIView()
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.lblSubTitle.bottomAnchor, constant: 10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 44 * 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let detailView = SignUpDetailView()
        detailView.fieldType = self.fieldType
        
        containerView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        detailView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        detailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 80).isActive = true
        
    }
    
    private func setupFieldView() {
        //        fieldView.backgroundColor = .green
        fieldDevelopmentView.delegate = self
        fieldDesignView.delegate = self
        
        self.addSubview(fieldView)
        
        fieldView.addSubview(fieldDevelopmentView)
        fieldView.addSubview(fieldDesignView)
        
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        fieldDevelopmentView.translatesAutoresizingMaskIntoConstraints = false
        fieldDesignView.translatesAutoresizingMaskIntoConstraints = false
        
        fieldView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //        fieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 128).isActive = true
        fieldView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        fieldView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        fieldView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
        fieldDevelopmentView.field = fieldButtonModels[0]
        fieldDesignView.field = fieldButtonModels[1]
        fieldDevelopmentView.index = 0
        fieldDesignView.index = 1
        
        fieldDevelopmentView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
        fieldDevelopmentView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        fieldDevelopmentView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        //        fieldDevelopmentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        fieldDevelopmentView.heightAnchor.constraint(equalTo: fieldView.heightAnchor, multiplier: 0.5).isActive = true
        
        fieldDesignView.topAnchor.constraint(equalTo: fieldDevelopmentView.bottomAnchor).isActive = true
        fieldDesignView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        fieldDesignView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        //        fieldDesignView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        fieldDesignView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
        fieldDesignView.heightAnchor.constraint(equalTo: fieldView.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func setupNicknameView() {
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
            let isValid = !(text ?? "").isEmpty
            self.isNicknameValid = isValid
            
            checkBadgeView.isHidden = !isValid
            self.delegate?.setButtonStyle(forState: isValid ? .active : .inActive)
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
    
    private func setFieldButtonState() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension SignUpViewCell: SignUpFieldButtonDelegate {
    public func fieldButton(selectedFieldType: FieldType) {
        ELog.debug(message: "Selected : \(selectedFieldType)")
        self.fieldType = selectedFieldType
        self.isFieldValid = true
    }
}

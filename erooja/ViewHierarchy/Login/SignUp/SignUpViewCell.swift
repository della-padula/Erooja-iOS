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
    
    public enum FieldType {
        case development
        case design
    }
    
    private let lblTitle = UILabel()
    
    private let fieldView = UIView()
    private let fieldDevelopmentView   = SignUpFieldButton()
    private let fieldDesignView   = SignUpFieldButton()
    
    private var fieldButtonModels = [Field(type: .development, title: "개발 직군", isActive: false, imageOn: .signup_field_dev_on, imageOff: .signup_field_dev_off), Field(type: .design,title: "디자인 직군", isActive: false, imageOn: .signup_field_design_on, imageOff: .signup_field_design_off)]
    
    private var fieldType: FieldType? {
        didSet {
            if fieldType == .development {
                fieldDevelopmentView.isActive = true
                fieldDesignView.isActive = false
            } else {
                fieldDevelopmentView.isActive = false
                fieldDesignView.isActive = true
            }
        }
    }
    
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
    
    private func setupDetailView() {
        
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
            checkBadgeView.isHidden = !isValid
            self.delegate?.nicknameValidation(isValid: isValid)
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
    public func fieldButton(selectedFieldType: SignUpViewCell.FieldType) {
        ELog.debug(message: "Selected : \(selectedFieldType)")
        self.fieldType = selectedFieldType
    }
}

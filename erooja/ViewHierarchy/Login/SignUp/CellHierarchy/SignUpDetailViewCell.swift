//
//  SignUpDetailViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class SignUpDetailViewCell: UICollectionViewCell {
    private var isDetailValid: Bool = false
    private let lblTitle = UILabel()
    private let lblSubTitle = UILabel()
    
    public let detailView = SignUpDetailView()
    
    public var viewModel: SignUpViewModel? {
        didSet {
            self.lblTitle.text    = viewModel?.title
            self.lblSubTitle.text = viewModel?.subTitle
        }
    }
    
    public var fieldType: FieldType? {
        didSet {
            setupDetailView()
        }
    }
    
    public var delegate: SignUpCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        self.setupDetailView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.lblTitle.text = self.viewModel?.title ?? "NO TITLE"
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
    
    private func setupDetailView() {
        self.lblSubTitle.text = self.viewModel?.subTitle ?? "NO TITLE"
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
        
        detailView.fieldType = SignUpBaseProperty.fieldType
        detailView.viewModel = SignUpDetailViewModel()
        detailView.delegate = self
        
        containerView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        detailView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        detailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60).isActive = true
    }
    
    public func checkButtonState() {
        delegate?.setButtonStyle(forState: isDetailValid ? .active : .inActive)
    }
}

extension SignUpDetailViewCell: SignUpDetailViewDelegate {
    public func detailView(selectedIndexList: [Bool]) {
        self.isDetailValid = true
        self.checkButtonState()
    }
}

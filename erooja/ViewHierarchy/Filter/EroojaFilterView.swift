//
//  EroojaFilterView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/17.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

public class EroojaFilterView: UIView {
    private let devTitleLabel = UILabel()
    private let designTitleLabel = UILabel()
    
    private let devJobListStackView = UIStackView()
    private let designJobListStackView = UIStackView()
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
        setLayoutProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViewLayout()
        setLayoutProperty()
//        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setViewLayout() {
        backgroundColor = .white
        addSubview(devTitleLabel)
        addSubview(designTitleLabel)
        addSubview(devJobListStackView)
        addSubview(designJobListStackView)
        
        devTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        devJobListStackView.translatesAutoresizingMaskIntoConstraints = false
        designTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        designJobListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        devTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        devTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        devTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        devTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        devJobListStackView.topAnchor.constraint(equalTo: devTitleLabel.bottomAnchor, constant: 20).isActive = true
        devJobListStackView.leadingAnchor.constraint(equalTo: devTitleLabel.leadingAnchor).isActive = true
        devJobListStackView.trailingAnchor.constraint(equalTo: devTitleLabel.trailingAnchor).isActive = true
        devJobListStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        designTitleLabel.topAnchor.constraint(equalTo: devJobListStackView.topAnchor, constant: 40).isActive = true
        designTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        designTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        designTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        designJobListStackView.topAnchor.constraint(equalTo: designTitleLabel.bottomAnchor, constant: 20).isActive = true
        designJobListStackView.leadingAnchor.constraint(equalTo: designTitleLabel.leadingAnchor).isActive = true
        designJobListStackView.trailingAnchor.constraint(equalTo: designTitleLabel.trailingAnchor).isActive = true
        designJobListStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func setLayoutProperty() {
        devTitleLabel.text = "개발"
        designTitleLabel.text = "디자인"
        
        // TEMP
        devTitleLabel.backgroundColor = .green
        designTitleLabel.backgroundColor = .blue
        
        devJobListStackView.backgroundColor = .cyan
        designJobListStackView.backgroundColor = .orange
    }
}

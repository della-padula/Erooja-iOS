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
    private var devFieldButtons = [JobItemButton]()
    private var designFieldButtons = [JobItemButton]()
    
    private let duplicateInfoLabel = UILabel()
    private let devTitleLabel = UILabel()
    private let designTitleLabel = UILabel()
    
    private let devJobListStackView = UIStackView()
    private let designJobListStackView = UIStackView()
    
    public var delegate: JobItemButtonDelegate?
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
        setLayoutProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViewLayout()
        setLayoutProperty()
    }
    
    fileprivate func setViewLayout() {
        backgroundColor = .white
        addSubview(devTitleLabel)
        addSubview(duplicateInfoLabel)
        addSubview(designTitleLabel)
        addSubview(devJobListStackView)
        addSubview(designJobListStackView)
        
        configureFilterStackView(type: .development)
        configureFilterStackView(type: .design)
        
        devJobListStackView.axis = .vertical
        devJobListStackView.distribution = .equalSpacing
        devJobListStackView.spacing = 8
        designJobListStackView.axis = .vertical
        designJobListStackView.distribution = .equalSpacing
        designJobListStackView.spacing = 8
        
        duplicateInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        devTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        devJobListStackView.translatesAutoresizingMaskIntoConstraints = false
        designTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        designJobListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        devTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        devTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        devTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        devTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        duplicateInfoLabel.centerYAnchor.constraint(equalTo: devTitleLabel.centerYAnchor).isActive = true
        duplicateInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        devJobListStackView.topAnchor.constraint(equalTo: devTitleLabel.bottomAnchor, constant: 20).isActive = true
        devJobListStackView.leadingAnchor.constraint(equalTo: devTitleLabel.leadingAnchor).isActive = true
        devJobListStackView.trailingAnchor.constraint(equalTo: devTitleLabel.trailingAnchor).isActive = true
        
        designTitleLabel.topAnchor.constraint(equalTo: devJobListStackView.bottomAnchor, constant: 40).isActive = true
        designTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        designTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        designTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        designJobListStackView.topAnchor.constraint(equalTo: designTitleLabel.bottomAnchor, constant: 20).isActive = true
        designJobListStackView.leadingAnchor.constraint(equalTo: designTitleLabel.leadingAnchor).isActive = true
        designJobListStackView.trailingAnchor.constraint(equalTo: designTitleLabel.trailingAnchor).isActive = true
        designJobListStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    fileprivate func setLayoutProperty() {
        devTitleLabel.text = "개발"
        devTitleLabel.textColor = EroojaColorSet.shared.gray100s
        devTitleLabel.font = .SpoqaBold16P
        
        designTitleLabel.text = "디자인"
        designTitleLabel.textColor = EroojaColorSet.shared.gray100s
        designTitleLabel.font = .SpoqaBold16P
        
        duplicateInfoLabel.text = "*중복 선택 가능"
        duplicateInfoLabel.textColor = EroojaColorSet.shared.gray300s
        duplicateInfoLabel.font = .SpoqaRegular12P
    }
    
    fileprivate func configureFilterStackView(type: FieldType) {
        if type == .development {
            let devFieldItems = JobType.Develop.allCases
            dynamicAppendButton(list: devFieldItems.map { $0.rawValue }, type: .development)
        } else if type == .design {
            let designFieldItems = JobType.Design.allCases
            dynamicAppendButton(list: designFieldItems.map { $0.rawValue }, type: .design)
        }
    }
    
    fileprivate func dynamicAppendButton(list: [String], type: FieldType) {
        var horizontalStackView: UIStackView?
        
        for (index, item) in list.enumerated() {
            if index % 2 == 0 {
                horizontalStackView = UIStackView()
                horizontalStackView?.axis = .horizontal
                horizontalStackView?.alignment = .center
                horizontalStackView?.distribution = .fill
                horizontalStackView?.spacing = 8
                
                let button = JobItemButton()
                button.title = item
                button.index = index
                button.delegate = self
                horizontalStackView?.addArrangedSubview(button)
            } else {
                let button = JobItemButton()
                button.title = item
                button.index = index
                button.delegate = self
                horizontalStackView?.addArrangedSubview(button)
            }
            
            if index % 2 == 1 || index == list.count - 1 {
                let spacingView = UIView()
                spacingView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                horizontalStackView?.addArrangedSubview(spacingView)
                
                if let horiView = horizontalStackView {
                    if type == .development {
                        devJobListStackView.addArrangedSubview(horiView)
                    } else if type == .design {
                        designJobListStackView.addArrangedSubview(horiView)
                    }
                }
            }
        }
    }
}

extension EroojaFilterView: JobItemButtonDelegate {
    public func onClickButton(jobItemButton: JobItemButton, index: Int, title: String?, isActive: Bool) {
        delegate?.onClickButton(jobItemButton: jobItemButton, index: index, title: title, isActive: isActive)
    }
}

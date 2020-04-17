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
    }
    
    fileprivate func setViewLayout() {
        backgroundColor = .white
        addSubview(devTitleLabel)
        addSubview(designTitleLabel)
        addSubview(devJobListStackView)
        addSubview(designJobListStackView)
        
        configureFilterStackView(type: .development)
        configureFilterStackView(type: .design)
        
        devJobListStackView.axis = .vertical
        devJobListStackView.distribution = .equalSpacing
        designJobListStackView.axis = .vertical
        designJobListStackView.distribution = .equalSpacing
        
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
        
        designTitleLabel.topAnchor.constraint(equalTo: devJobListStackView.bottomAnchor, constant: 40).isActive = true
        designTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        designTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        designTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        designJobListStackView.topAnchor.constraint(equalTo: designTitleLabel.bottomAnchor, constant: 20).isActive = true
        designJobListStackView.leadingAnchor.constraint(equalTo: designTitleLabel.leadingAnchor).isActive = true
        designJobListStackView.trailingAnchor.constraint(equalTo: designTitleLabel.trailingAnchor).isActive = true
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
    
    fileprivate func configureFilterStackView(type: FieldType) {
        if type == .development {
//            let devCount = JobType.Develop.allCases.count
            let devFieldItems = JobType.Develop.allCases
            dynamicAppendButton(list: devFieldItems.map { $0.rawValue }, type: .development)
        } else if type == .design {
//            let designCount = JobType.Design.allCases.count
            let designFieldItems = JobType.Design.allCases
            dynamicAppendButton(list: designFieldItems.map { $0.rawValue }, type: .design)
        }
    }
    
    fileprivate func dynamicAppendButton(list: [String], type: FieldType) {
        var horizontalStackView: UIStackView?
        horizontalStackView?.axis = .horizontal
        horizontalStackView?.distribution = .equalSpacing
        
        for (index, item) in list.enumerated() {
            if index % 2 == 0 {
                // First Column
                horizontalStackView = UIStackView()
                
                let button = JobItemButton()
                button.title = item
                
                horizontalStackView?.addArrangedSubview(button)
            } else {
                // Second Column
                let button = JobItemButton()
                button.title = item
                
                horizontalStackView?.addArrangedSubview(button)
                
                if let horiStackView = horizontalStackView {
                    if type == .development {
                        devJobListStackView.addArrangedSubview(horiStackView)
                    } else if type == .design {
                        designJobListStackView.addArrangedSubview(horiStackView)
                    }
                }
            }
        }
    }
}

//
//  CreateGoalFirstCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

public class CreateGoalFirstCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollContentView: UIView!
    private var filterView = EroojaFilterView()
    
    public var delegate: CreateGoalHeaderViewDelegate?
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setViewLayout()
        
        // TEMP
        delegate?.rightButton(at: .second, active: true)
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    fileprivate func setViewLayout() {
        self.scrollContentView.addSubview(filterView)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        filterView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        filterView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor).isActive = true
    }
}

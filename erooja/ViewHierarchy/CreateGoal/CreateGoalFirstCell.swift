//
//  CreateGoalFirstCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public class CreateGoalFirstCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    public var delegate: CreateGoalHeaderViewDelegate?
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // TEMP
        delegate?.rightButton(at: .second, active: true)
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

//
//  CreateGoalThirdCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaCommon
import EroojaUI

public class CreateGoalThirdCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.backgroundColor = .cyan
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  GoalDetailItemCell.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI

public class GoalDetailItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgColorView: UIView!
    @IBOutlet weak var dotView: UIView!
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setViewLayout()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setViewLayout() {
        dotView.layer.cornerRadius = dotView.bounds.width / 2
        dotView.backgroundColor = EroojaColorSet.shared.orgDefault400
        bgColorView.layer.cornerRadius = 12
        bgColorView.backgroundColor = EroojaColorSet.shared.gray100
    }
    
}

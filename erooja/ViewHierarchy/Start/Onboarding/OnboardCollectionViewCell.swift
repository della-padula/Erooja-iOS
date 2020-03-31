//
//  OnboardCollectionViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public struct OnboardItem {
    let mainText: String
    let subText: String
    let image: UIImage
}

public class OnboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblMainText: UILabel!
    @IBOutlet weak var lblSubText: UILabel!
    
    @IBOutlet var lblMainTextHeight: NSLayoutConstraint!
    @IBOutlet var lblSubTextHeight: NSLayoutConstraint!
    
    public var item: OnboardItem? {
        didSet {
            self.imageView.image = item?.image
            self.lblMainText.text = item?.mainText
            self.lblSubText.text = item?.subText
            
            self.lblSubText.setLinespace(spacing: 5)
            self.lblSubText.textAlignment = .center
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblMainText.font = .AppleSDBold20P
        self.lblSubText.font = .AppleSDSemiBold15P
    }

}

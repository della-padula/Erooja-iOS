//
//  OnboardCollectionViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

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
    @IBOutlet weak var viewTopAnchor: NSLayoutConstraint!
    
    public var bottomViewHeight: CGFloat = 56
    
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
        
        self.lblMainText.textColor = .EROOJAGRAY33
        self.lblSubText.textColor = .EROOJAGRAY75
        
        self.setupLayout()
    }
    
    private func setupLayout() {
        let cellHeight = UIScreen.main.bounds.height - bottomViewHeight
        let viewHeight = self.imageView.frame.height + self.lblMainText.frame.height + self.lblSubText.frame.height
        
        ELog.debug(message: "collectionView Cell Height : \(cellHeight)")
        ELog.debug(message: "cellHeight - viewHeight : \(cellHeight - viewHeight)")
        ELog.debug(message: "topAnchor : \((cellHeight - viewHeight) * 114 / 192)")
        ELog.debug(message: "bottomAnchor : \((cellHeight - viewHeight) * 78 / 192)")
        
        let topAnchor = (cellHeight - viewHeight) * 114 / 192
        viewTopAnchor.constant = topAnchor
        
        // 114 : 78
    }

}

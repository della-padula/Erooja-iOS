//
//  CreateGoalThirdCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaCommon
import EroojaUI
import KMPlaceholderTextView

public class CreateGoalThirdCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: KMPlaceholderTextView!
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setViewLayout()
    }
    
    private func setViewLayout() {
        textView.font = .SpoqaRegular15P
        textView.placeholder = "이 목표는 애프터이펙트/모션그래픽 역량\n함양을 위한 단기간 영상 제작 프로젝트입니다.\n간단한 모션 제작을 통해 ~하려 합니다.\n(내용 생략 가능)"
        textView.textColor = EroojaColorSet.shared.gray100s
        textView.tintColor = EroojaColorSet.shared.orgDefault400s
    }
}

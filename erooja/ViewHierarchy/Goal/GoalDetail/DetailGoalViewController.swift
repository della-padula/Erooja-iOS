//
//  DetailGoalViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/18.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

class DetailGoalViewController: BaseViewController {
    @IBOutlet weak var detailTopSectionView: UIView!
    @IBOutlet weak var navigationBar: EUIHeaderView!
    
    @IBOutlet weak var detailTopDateLabel: UILabel!
    @IBOutlet weak var detailTopTitleLabel: UILabel!
    @IBOutlet weak var detailTopContentLabel: UILabel!
    @IBOutlet weak var downArrowButton: UIView!
    @IBOutlet weak var downArrowButtonImage: UIImageView!
    
    private var isSpreaded: Bool = false
    
    @IBAction func onClickSpreadButton(_ sender: UIButton) {
        isSpreaded = !isSpreaded
        detailTopContentLabel.numberOfLines = isSpreaded ? 0 : 3
        downArrowButtonImage.image = isSpreaded ? .goalDetailUpArrow : .goalDetailDownArrow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
    }

    private func setViewLayout() {
        setStatusBarBackground()
        setNavigationBar()
        setTopSectionView()
    }
    
    fileprivate func setTopSectionView() {
        detailTopSectionView.clipsToBounds = true
        detailTopSectionView.layer.cornerRadius = 20
        detailTopSectionView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        detailTopSectionView.backgroundColor = EroojaColorSet.shared.orgDefault400
        
        detailTopTitleLabel.font = .SpoqaBold20P
        detailTopDateLabel.font = .SpoqaLight14P
        detailTopDateLabel.textColor = EroojaColorSet.shared.white100
        detailTopTitleLabel.textColor = EroojaColorSet.shared.white100
    }
    
    fileprivate func setNavigationBar() {
        navigationBar.barOptions = [.backButton, .rightSecondButton]
        navigationBar.setRightButtonColor(position: .second, colorActive: EroojaColorSet.shared.white100, colorInActive: EroojaColorSet.shared.white100)
        navigationBar.delegate = self
        navigationBar.rightSecondButtonType = .image
        navigationBar.setBackButtonImage(image: .goalDetailBackArrow)
        navigationBar.setRightButtonImage(position: .second, image: .goalDetailMenu)
        
        navigationBar.backgroundColor = EroojaColorSet.shared.orgDefault400
    }
    
    fileprivate func setStatusBarBackground() {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let safeAreaBGView = UIView()
            self.view.addSubview(safeAreaBGView)
            safeAreaBGView.backgroundColor = EroojaColorSet.shared.orgDefault400
            safeAreaBGView.translatesAutoresizingMaskIntoConstraints = false
            safeAreaBGView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            safeAreaBGView.heightAnchor.constraint(equalToConstant: topPadding!).isActive = true
            safeAreaBGView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            safeAreaBGView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }
}

extension DetailGoalViewController: EUINavigationBarDelegate {
    public func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didChangeTextField(_ textField: EroojaTextField, text: String?) {
        
    }
    
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        
    }
}

//
//  GoalDetailViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/18.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class GoalDetailViewController: BaseViewController {
    private var navigationBar = EUIHeaderView()
    private var scrollView = UIScrollView()
    private var scrollContentView = UIView()
    
    private var topContentView = UIView()
    private var topDateLabel = UILabel()
    private var topTitleLabel = UILabel()
    private var topContentLabel = UILabel()
    private var topLogoImageView = UIImageView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
    }
    
    fileprivate func setViewLayout() {
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
        
        self.view.backgroundColor = EroojaColorSet.shared.white100
        self.navigationBar.barOptions = [.backButton, .rightSecondButton]
        self.view.addSubview(self.navigationBar)
        
        self.navigationBar.setRightButtonColor(position: .second, colorActive: EroojaColorSet.shared.white100, colorInActive: EroojaColorSet.shared.white100)
        self.navigationBar.delegate = self
        self.navigationBar.rightSecondButtonType = .image
        self.navigationBar.setBackButtonImage(image: .goalDetailBackArrow)
        self.navigationBar.setRightButtonImage(position: .second, image: .goalDetailMenu)
        
        
        self.navigationBar.backgroundColor = EroojaColorSet.shared.orgDefault400
        self.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // Scroll View Setting
        self.scrollView.backgroundColor = .green
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.scrollView.addSubview(scrollContentView)
        self.scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.scrollContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.scrollContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        
        // Top Section View Layout
//        self.topContentView.backgroundColor = EroojaColorSet.shared.orgDefault400
        self.topContentView.backgroundColor = .cyan
        self.topContentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16.0)
        self.scrollContentView.addSubview(topContentView)
//        self.topContentView.addSubview(topDateLabel)
//        self.topContentView.addSubview(topTitleLabel)
//        self.topContentView.addSubview(topLogoImageView)
        
//        self.topDateLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContentView.translatesAutoresizingMaskIntoConstraints = false
//        self.topLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.topContentView.topAnchor.constraint(equalTo: scrollContentView.topAnchor).isActive = true
        self.topContentView.leadingAnchor.constraint(equalTo: self.scrollContentView.leadingAnchor).isActive = true
        self.topContentView.trailingAnchor.constraint(equalTo: self.scrollContentView.trailingAnchor).isActive = true
        self.topContentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}

extension GoalDetailViewController: EUINavigationBarDelegate {
    public func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didChangeTextField(_ textField: EroojaTextField, text: String?) {
        
    }
    
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

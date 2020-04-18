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
    private var contentView = UIView()
    
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
        setNavigationLayout()
        
        // Scroll View Setting
        contentView.backgroundColor = .systemBlue
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Top Section View Layout
        contentView.addSubview(topContentView)
        topContentView.backgroundColor = EroojaColorSet.shared.orgDefault400
        
        self.topContentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.topContentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.topContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.topContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.topContentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    fileprivate func setNavigationLayout() {
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
        
//        view.backgroundColor = EroojaColorSet.shared.white100
        navigationBar.barOptions = [.backButton, .rightSecondButton]
        view.addSubview(navigationBar)
        
        navigationBar.setRightButtonColor(position: .second, colorActive: EroojaColorSet.shared.white100, colorInActive: EroojaColorSet.shared.white100)
        navigationBar.delegate = self
        navigationBar.rightSecondButtonType = .image
        navigationBar.setBackButtonImage(image: .goalDetailBackArrow)
        navigationBar.setRightButtonImage(position: .second, image: .goalDetailMenu)
        
        navigationBar.backgroundColor = EroojaColorSet.shared.orgDefault400
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
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

//
//  SignUpViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import EroojaUI
import UIKit

public class SignUpViewController: BaseViewController {
    private var collectionPageView: UICollectionView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBar()
        self.setViewLayout()
    }
    
    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 44)
        
        self.collectionPageView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    }
    
    private func setNavigationBar() {
        let navigationView = UIView()
        let backButton = UIButton()
        
        navigationView.backgroundColor = .white
        view.addSubview(navigationView)
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        backButton.setImage(UIImage(named: "back_button"), for: .normal)
        backButton.backgroundColor = .white
        navigationView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor).isActive = true
        backButton.heightAnchor.constraint(equalTo: navigationView.heightAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
    }
    
    private func setViewLayout() {
        let bottomButton = UIButton()
        bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400s
        bottomButton.setTitle("다음", for: .normal)
        bottomButton.titleLabel?.font = .AppleSDRegular14P
        bottomButton.setTitleColor(EroojaColorSet.shared.whiteBg000s, for: .normal)
        
        view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

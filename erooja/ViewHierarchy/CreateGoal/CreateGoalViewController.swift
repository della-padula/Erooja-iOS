//
//  CreateGoalViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class CreateGoalViewController: BaseViewController {
    private var contentCollectionView: UICollectionView?
    private let headerView = EUIHeaderView()
    public var viewModel: CreateGoalViewModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bindViewModel()
        setContentView()
        
        viewModel?.setProgressValue(value: 0.5)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.progressValue.bind({ progress in
                ELog.debug(message: "Progress : \(progress)")
                self.headerView.setProgressValue(value: CGFloat(Float(progress)))
            })
        }
    }
    
    fileprivate func setContentView() {
        headerView.barOptions = [.backButton, .progressBar, .rightSecondButton]
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - self.headerView.height)
        
//        contentCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
//
//        view.addSubview(contentCollectionView!)
//        contentCollectionView?.translatesAutoresizingMaskIntoConstraints = false
//        contentCollectionView?.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
//        contentCollectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        contentCollectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        contentCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        contentCollectionView?.delegate = self
//        contentCollectionView?.dataSource = self
    }
}

extension CreateGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

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
    private let contentCollectionView = UICollectionView()
    public var viewModel: CreateGoalViewModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setContentView()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.progressValue.bind({ progress in
                ELog.debug(message: "Progress : \(progress)")
            })
        }
    }
    
    fileprivate func setContentView() {
        self.contentCollectionView.delegate = self
        self.contentCollectionView.dataSource = self
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

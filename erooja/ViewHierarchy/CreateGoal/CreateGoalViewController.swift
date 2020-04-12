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
        headerView.rightSecondButtonType = .text
        headerView.setRightButtonTitle(position: .second, title: "다음")
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - self.headerView.height)
        
        contentCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        contentCollectionView?.register(UINib(nibName: "CreateGoalFirstCell", bundle: nil), forCellWithReuseIdentifier: "createFirstCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalSecondCell", bundle: nil), forCellWithReuseIdentifier: "createSecondCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalThirdCell", bundle: nil), forCellWithReuseIdentifier: "createThirdCell")
        
        contentCollectionView?.backgroundColor = .white
        contentCollectionView?.isScrollEnabled = true
        contentCollectionView?.isPagingEnabled = true
        contentCollectionView?.delegate = self
        contentCollectionView?.dataSource = self
        
        view.addSubview(contentCollectionView!)
        contentCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        contentCollectionView?.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentCollectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentCollectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        headerView.setRightButtonActive(position: .second, isActive: true)
        headerView.delegate = self
    }
}

extension CreateGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createFirstCell", for: indexPath) as! CreateGoalFirstCell
            cell.titleText = "테스트 타이틀 \(indexPath.row)"
            cell.backgroundColor = .green
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createSecondCell", for: indexPath) as! CreateGoalSecondCell
            cell.titleText = "테스트 타이틀 \(indexPath.row)"
            cell.backgroundColor = .blue
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createThirdCell", for: indexPath) as! CreateGoalThirdCell
            cell.titleText = "테스트 타이틀 \(indexPath.row)"
            cell.backgroundColor = .red
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CreateGoalViewController: EUINavigationBarDelegate {
    public func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didChangeTextField(_ textField: EroojaTextField, text: String?) { }
    
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        ELog.debug(message: "Position: \(position)")
        viewModel?.setProgressValue(value: (viewModel?.progressValue.valueForBind ?? 0) + 0.1)
    }
    
    
}

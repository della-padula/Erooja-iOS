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
    private let stageCount = 5
    
    private var currentIndex = 0
    
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
        viewModel?.setProgressValue(value: 0.2)
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - self.headerView.height)
        
        contentCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        contentCollectionView?.register(UINib(nibName: "CreateGoalFirstCell", bundle: nil), forCellWithReuseIdentifier: "createFirstCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalSecondCell", bundle: nil), forCellWithReuseIdentifier: "createSecondCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalThirdCell", bundle: nil), forCellWithReuseIdentifier: "createThirdCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalFourthCell", bundle: nil), forCellWithReuseIdentifier: "createFourthCell")
        contentCollectionView?.register(UINib(nibName: "CreateGoalFifthCell", bundle: nil), forCellWithReuseIdentifier: "createFifthCell")
        
        contentCollectionView?.backgroundColor = .white
        contentCollectionView?.isScrollEnabled = false
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
        return stageCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createFirstCell", for: indexPath) as! CreateGoalFirstCell
            cell.titleText = "어떤 직무와 관련된 목표인가요?"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createSecondCell", for: indexPath) as! CreateGoalSecondCell
            cell.titleText = "어떤 목표를 달성하려고 하세요?"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createThirdCell", for: indexPath) as! CreateGoalThirdCell
            cell.titleText = "어떤 목표인지\n조금 더 자세히 설명해주시겠어요?"
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createFourthCell", for: indexPath) as! CreateGoalFourthCell
            cell.titleText = "목표 기간을 설정해주세요."
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createFifthCell", for: indexPath) as! CreateGoalFifthCell
            cell.titleText = "기간 내 달성할 세부 목표 리스트를\n만들어보세요."
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
        currentIndex += 1
        if currentIndex == stageCount - 1 {
            headerView.setRightButtonActive(position: .second, isActive: false)
        }
        
        ELog.debug(message: "Position: \(position)")
        ELog.debug(message: "Current Progress : \(Double(Double(currentIndex + 1) / Double(stageCount)))")
        
        let progress = Double(Double(currentIndex + 1) / Double(stageCount))
        viewModel?.setProgressValue(value: progress)
        contentCollectionView?.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .right, animated: false)
    }
    
    
}

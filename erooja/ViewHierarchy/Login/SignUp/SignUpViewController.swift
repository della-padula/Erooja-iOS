//
//  SignUpViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import EroojaNetwork
import EroojaUI
import UIKit

public protocol SignUpCellDelegate {
    func setButtonStyle(forState: ButtonState)
}

public class SignUpViewController: BaseViewController {
    private var collectionPageView: UICollectionView?
    private var navigationView = UIView()
    private var backButton = UIButton()
    private var bottomButton = UIButton()
    
    private var currentPage : Int = 0
    
    private let viewModels: [SignUpViewModel] = [SignUpViewModel(title: "닉네임을 입력하세요.", type: .nickname), SignUpViewModel(title: "관심있는 직군을 골라주세요.", type: .field), SignUpViewModel(title: "직무도 함께 골라주세요.", subTitle: "직무는 추후에 변경 가능합니다.", type: .detail)]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setNavigationBar()
        self.setViewLayout()
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 132)
        
        self.collectionPageView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionPageView?.backgroundColor = .clear
        self.collectionPageView?.isPagingEnabled = true
        self.collectionPageView?.isScrollEnabled = false
        self.collectionPageView?.register(SignUpNicknameViewCell.self, forCellWithReuseIdentifier: "SignUpNicknameViewCell")
        self.collectionPageView?.register(SignUpFieldViewCell.self, forCellWithReuseIdentifier: "SignUpFieldViewCell")
        self.collectionPageView?.register(SignUpDetailViewCell.self, forCellWithReuseIdentifier: "SignUpDetailViewCell")
        
        view.addSubview(self.collectionPageView!)
        self.collectionPageView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionPageView!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88).isActive = true
        self.collectionPageView!.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor).isActive = true
        self.collectionPageView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionPageView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.collectionPageView?.delegate = self
        self.collectionPageView?.dataSource = self
    }
    
    private func setNavigationBar() {
//        self.navigationView.backgroundColor = .green
        self.view.addSubview(self.navigationView)
        
        self.navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.backButton.setImage(UIImage(named: "back_button"), for: .normal)
        self.backButton.backgroundColor = .white
        self.backButton.isHidden = true
        self.backButton.addTarget(self, action: #selector(onClickPrev), for: .touchUpInside)
        self.navigationView.addSubview(self.backButton)
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.centerYAnchor.constraint(equalTo: self.navigationView.centerYAnchor).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.navigationView.leadingAnchor).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: self.navigationView.heightAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalTo: self.backButton.heightAnchor).isActive = true
    }
    
    private func setViewLayout() {
        bottomButton.setTitle("다음", for: .normal)
        bottomButton.titleLabel?.font = .SpoqaRegular15P
        
        bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400
        bottomButton.setTitleColor(EroojaColorSet.shared.white100, for: .normal)
        bottomButton.addTarget(self, action: #selector(onClickNext), for: .touchUpInside)
        
        view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc
    public func onClickNext() {
        currentPage += 1
        backButton.isHidden = false
        
        if currentPage > (viewModels.count - 1) {
            currentPage -= 1
            ELog.debug("화면 전환이 이루어집니다.")
            ELog.debug(SignUpBaseProperty.nickname)
            ELog.debug(SignUpBaseProperty.fieldType?.rawValue)
            
            for (index, isSelected) in SignUpBaseProperty.detailSelectedIndexList.enumerated() {
                if isSelected {
                    if SignUpBaseProperty.fieldType == .development {
                        ELog.debug("\(JobType.Develop.allCases[index].rawValue)")
                    } else {
                        ELog.debug("\(JobType.Design.allCases[index].rawValue)")
                    }
                }
            }
            SignUpBaseProperty.detailSelectedIndexList = SignUpBaseProperty.detailSelectedIndexList.map { $0 && false }
            
//            #if DEBUG
//            LoginSwitcher.updateRootVC(type: .uitest)
//            #else
            LoginSwitcher.updateRootVC(type: .main)
//            #endif
        } else {
            self.collectionPageView?.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: false)
            if currentPage == 2 && SignUpBaseProperty.isReloadDetailCell {
                ELog.debug("Update Detail")
                SignUpBaseProperty.detailSelectedIndexList = SignUpBaseProperty.detailSelectedIndexList.map { $0 && false }
                SignUpBaseProperty.isReloadDetailCell = false
                self.collectionPageView?.reloadItems(at: [IndexPath(row: 2, section: 0)])
                self.setButtonStyle(forState: .inActive)
            }
        }
    }
    
    @objc
    public func onClickPrev() {
        currentPage -= 1
        if currentPage < 0 {
            currentPage += 1
        } else {
            backButton.isHidden = (currentPage == 0)
            self.collectionPageView?.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch self.currentPage {
        case 0:
            let _cell = cell as! SignUpNicknameViewCell
            _cell.checkButtonState()
        case 1:
            let _cell = cell as! SignUpFieldViewCell
            _cell.checkButtonState()
        case 2:
            let _cell = cell as! SignUpDetailViewCell
            _cell.checkButtonState()
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModels[indexPath.row].type {
        case .nickname:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpNicknameViewCell", for: indexPath) as! SignUpNicknameViewCell
            cell.viewModel = viewModels[indexPath.row]
            cell.delegate = self
            cell.checkButtonState()
            return cell
        case .field:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpFieldViewCell", for: indexPath) as! SignUpFieldViewCell
            cell.viewModel = viewModels[indexPath.row]
            cell.delegate = self
            return cell
        case .detail:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpDetailViewCell", for: indexPath) as! SignUpDetailViewCell
            cell.viewModel = viewModels[indexPath.row]
            cell.fieldType = SignUpBaseProperty.fieldType
            cell.delegate = self
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        ELog.debug("setButton Current Page : \(self.currentPage)")
    }
    
}

extension SignUpViewController: SignUpCellDelegate {
    public func nicknameValidation(isValid: Bool) {
        self.setButtonStyle(forState: isValid ? .active : .inActive)
    }
    
    public func setButtonStyle(forState: ButtonState) {
        switch forState {
        case .active:
            bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400
            bottomButton.setTitleColor(EroojaColorSet.shared.white100, for: .normal)
            bottomButton.isEnabled = true
        case .inActive:
            bottomButton.backgroundColor = EroojaColorSet.shared.gray300
            bottomButton.setTitleColor(EroojaColorSet.shared.gray500, for: .normal)
            bottomButton.isEnabled = false
        }
    }
}

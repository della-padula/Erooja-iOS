//
//  OnboardViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import UIKit

public class OnboardViewController: UIViewController {
    private var onboardItems = [
        OnboardItem(mainText: "목표 템플릿을 이용해보세요", subText: "이루자에서만 만나볼 수 있는\n목표 리스트를 이용해보세요!", image: .onboard_1),
        OnboardItem(mainText: "목표를 함께 달성하세요", subText: "목표를 함께 이뤄보세요. 함께 달성할\n누군가 있다는 건 참 든든한 일이에요.", image: .onboard_2),
        OnboardItem(mainText: "나의 달성률을 확인하세요", subText: "달성률을 확인함으로써 목표를 이루는데\n동기를 부여받을 수 있어요!", image: .onboard_3)
    ]
    
    private var collectionView: UICollectionView?
    
    private var bottomView  = UIView()
    private var pageControl = EPageControl()
    private var skipButton  = UIButton()
    private var nextButton  = UIButton()
    
    private var currentPage = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    
    private func setupView() {
        self.setBottomToolSet()
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - self.bottomView.height)
        
        self.collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionView?.backgroundColor = .white
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        self.collectionView!.register(UINib(nibName: "OnboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardCell")
        self.collectionView!.isScrollEnabled = false
//        self.collectionView?.isPagingEnabled = true
        
        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView!)
        
        self.collectionView!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.collectionView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView!.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
        
    }
    
    private func setBottomToolSet() {
       self.bottomView.backgroundColor = .clear
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.bottomView)
        self.bottomView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // Next Button
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.addTarget(self, action: #selector(onClickNextButton), for: .touchUpInside)
        self.nextButton.titleLabel?.font = .SpoqaRegular15P
        self.nextButton.setTitleColor(EroojaColorSet.shared.orgDefault400s, for: .normal)
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(nextButton)
        
        self.nextButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        self.nextButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        self.nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor, multiplier: 73/48).isActive = true
        
        // Skip Button
        self.skipButton.setTitle("Skip", for: .normal)
        self.skipButton.addTarget(self, action: #selector(onClickSkipButton), for: .touchUpInside)
        self.skipButton.titleLabel?.font = .SpoqaRegular15P
        self.skipButton.setTitleColor(EroojaColorSet.shared.gray300s, for: .normal)
        
        self.skipButton.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(skipButton)
        
        self.skipButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        self.skipButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        self.skipButton.widthAnchor.constraint(equalTo: skipButton.heightAnchor, multiplier: 73/48).isActive = true
        
        // UIPageControl
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = currentPage
        self.pageControl.indicatorDiameter = 9
        self.pageControl.currentIndicatorDiameter = 9
        self.pageControl.spacing = 20
        self.pageControl.indicatorTintColor = EroojaColorSet.shared.gray400s
        self.pageControl.currentIndicatorTintColor = EroojaColorSet.shared.orgDefault400s
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(pageControl)
        
        self.pageControl.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor).isActive = true
        self.pageControl.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor).isActive = true
        self.pageControl.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
    }
    
    @objc
    private func onClickNextButton() {
        self.currentPage += 1
        if self.currentPage > 2 {
            self.goToLoginView()
        } else {
            self.collectionView!.collectionViewLayout.invalidateLayout()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.collectionView!.scrollToItem(at: IndexPath(row: self.currentPage, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    @objc
    private func onClickSkipButton() {
        self.goToLoginView()
    }
    
    private func goToLoginView() {
        #if DEBUG
        LoginSwitcher.updateRootVC(type: .uitest)
        #else
        LoginSwitcher.updateRootVC(type: .login)
        #endif
    }
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardCell", for: indexPath) as! OnboardCollectionViewCell
        cell.item = onboardItems[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        ELog.debug(message: "(Did End Display) Current Page : \(self.currentPage)")
        self.pageControl.currentPage = self.currentPage
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x / w))
        
        self.currentPage = currentPage
        self.pageControl.currentPage = self.currentPage
    }
}

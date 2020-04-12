//
//  SearchViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import EroojaNetwork
import EroojaSharedBase

public class SearchViewController: BaseViewController {
    private var navigationBar = EUIHeaderView()
    public var viewModel: SearchViewModel?
    private var selectedIndex: Int = 0
    
    private let buttonStackView = UIStackView()
    private let jobButton = ETabButton(tag: 0)
    private let goalButton = ETabButton(tag: 1)
    
    private let resultPlaceholderView = EPlaceholderView()
    private let resultView = UIView()
    private let resultTableView = UITableView()
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.bindViewModel()
        self.setViewLayout()
    }
    
    @objc
    private func onClickSearch(keyword: String) {
        
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.resultList.bind({ (resultList) in
                DispatchQueue.main.async {
                    ELog.debug(message: "Result List Count : \(resultList.count)")
                }
            })
        }
    }
    
    private func setViewLayout() {
        self.navigationBar.barOptions = [.backButton, .textField, .rightSecondButton]
        self.view.addSubview(self.navigationBar)
        
        self.navigationBar.delegate = self
        self.navigationBar.rightSecondButtonType = .image
        self.navigationBar.setRightButtonImage(position: .second, image: UIImage.search_button)
        
        self.navigationBar.backgroundColor = .white
        self.navigationBar.textFieldPlaceholder = "검색어를 입력해주세요."
        self.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.setToggleButtonLayout()
        
        self.view.addSubview(self.resultView)
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        
        self.resultView.topAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor).isActive = true
        self.resultView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.resultView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.resultView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.resultTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        
        self.resultView.addSubview(self.resultTableView)
        self.resultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.resultTableView.topAnchor.constraint(equalTo: self.resultView.topAnchor).isActive = true
        self.resultTableView.leadingAnchor.constraint(equalTo: self.resultView.leadingAnchor).isActive = true
        self.resultTableView.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor).isActive = true
        self.resultTableView.bottomAnchor.constraint(equalTo: self.resultView.bottomAnchor).isActive = true
        
        self.resultView.addSubview(resultPlaceholderView)
        resultPlaceholderView.imageHeight = 150
        resultPlaceholderView.image = .mainLogo
        resultPlaceholderView.text = "Test Placeholder"
        resultPlaceholderView.textColor = EroojaColorSet.shared.gray000s
        resultPlaceholderView.font = .AppleSDSemiBold14P
        self.resultPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.resultPlaceholderView.backgroundColor = .green
        self.resultPlaceholderView.leadingAnchor.constraint(equalTo: self.resultView.leadingAnchor, constant: 30).isActive = true
        self.resultPlaceholderView.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor, constant: -30).isActive = true
        self.resultPlaceholderView.centerXAnchor.constraint(equalTo: self.resultView.centerXAnchor).isActive = true
        self.resultPlaceholderView.centerYAnchor.constraint(equalTo: self.resultView.centerYAnchor).isActive = true
    }
    
    private func setToggleButtonLayout() {
        
        jobButton.delegate = self
        goalButton.delegate = self
        
//        jobButton.setTitle("직무", for: .normal)
//        jobButton.backgroundColor = .green
        jobButton.title = "직무"
        jobButton.isActive = true
        jobButton.barTintColor = .black
        
//        goalButton.setTitle("목표", for: .normal)
//        goalButton.backgroundColor = .cyan
        goalButton.title = "목표"
        goalButton.isActive = false
        goalButton.barTintColor = .black
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.addArrangedSubview(jobButton)
        buttonStackView.addArrangedSubview(goalButton)
        
        self.view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
}

extension SearchViewController: EUINavigationBarDelegate {
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        ELog.debug(message: "Right Button Click : position - \(position)")
    }
    
    public func onClickBackButton() {
        ELog.debug(message: "Back Button Click")
        #if DEBUG
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        #else
        self.navigationController?.popViewController(animated: true)
        #endif
    }
}

extension SearchViewController: ETabButtonDelegate {
    public func onClickButton(_ button: ETabButton, tag: Int) {
        ELog.debug(message: "Clicked : \(tag)")
        setButtonState(tag: tag)
        
        // MARK: TEST
        resultPlaceholderView.isHidden = tag > 0 ? true : false
        resultTableView.isHidden = tag > 0 ? false : true
    }
    
    fileprivate func setButtonState(tag: Int) {
        for button in buttonStackView.subviews.enumerated() {
            if let button = button.element as? ETabButton {
                if button.tag != tag {
                    ELog.debug(message: "setFalse : \(button.tag)")
                    button.isActive = false
                } else {
                    ELog.debug(message: "setTrue : \(button.tag)")
                    button.isActive = true
                    selectedIndex = tag
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ELog.debug(message: "Selected Table Cell : \(indexPath.row)")
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.title = "TEST \(indexPath.row)"
        cell.selectionStyle = .none
        ELog.debug(message: "TEST \(indexPath.row)")
        return cell
    }
}

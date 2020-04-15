//
//  CreateGoalThirdCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaCommon
import EroojaUI

public class CreateGoalDetailView: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    public var delegate: CreateGoalHeaderViewDelegate?
    public var viewModel = CreateGoalDetailViewModel()
    
    private var detailList = [String]()
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        ELog.debug(message: "CreateGoalDetailView")
        bindViewModel()
        setViewLayout()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    private func setViewLayout() {
        
        detailTableView.tableFooterView = UIView()
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
        let itemNibName = UINib(nibName: "GoalDetailItemCell", bundle: nil)
        let inputNibName = UINib(nibName: "GoalDetailItemInputCell", bundle: nil)
        
        detailTableView.register(inputNibName, forCellReuseIdentifier: "goalDetailInputCell")
        detailTableView.register(itemNibName, forCellReuseIdentifier: "goalDetailItemCell")
    }
    
    fileprivate func bindViewModel() {
            viewModel.detailList.bind({ (detailList) in
                DispatchQueue.main.async {
                    ELog.debug(message: "[CreateGoalDetailView] detailList count : \(detailList.count)")
                    self.detailList = detailList
                    self.detailTableView.reloadData()
                }
            })
    }
}

extension CreateGoalDetailView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ELog.debug(message: "tableView numberOfRowsInSection")
        return self.detailList.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var lastIndex = 0
        if (self.detailList.count) < 1 {
            lastIndex = 0
        } else {
            lastIndex = (self.detailList.count)
        }
        
        ELog.debug(message: "lastIndex : \(lastIndex), indexPath.row : \(indexPath.row)")
        ELog.debug(message: "isLastItem : \(indexPath.row == lastIndex)")
        
        if indexPath.row == lastIndex {
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailInputCell")
                                        as! GoalDetailItemInputCell
            inputCell.delegate = self
            inputCell.selectionStyle = .none
            return inputCell
        } else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailItemCell")
                                        as! GoalDetailItemCell
            itemCell.title = self.detailList[indexPath.row]
            return itemCell
        }
    }
}

extension CreateGoalDetailView: GoalDetailInputDelegate {
    public func returnKeyEvent(_ textField: UITextField, content: String?) {
        ELog.debug(message: "[CreateGoalDetailView] Return : \(content)")
        let strongContent = content ?? ""
        if strongContent.isEmpty {
            // Empty Process
        } else {
            viewModel.append(item: strongContent)
        }
    }
}


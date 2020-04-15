//
//  CreateGoalThirdCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaCommon
import EroojaUI

public class CreateGoalFifthCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    public var delegate: CreateGoalHeaderViewDelegate?
    public var viewModel: CreateGoalDetailViewModel?
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        bindViewModel()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    fileprivate func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.detailList.bind({ (detailList) in
                DispatchQueue.main.async {
                    ELog.debug(message: "[CreateGoalDetailView] detailList count : \(detailList.count)")
                }
            })
        }
    }
}

extension CreateGoalFifthCell: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailItemCell") as! GoalDetailItemCell
        
        let inputCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailInputCell") as! GoalDetailItemInputCell
        
        
        
        return UITableViewCell()
    }
}

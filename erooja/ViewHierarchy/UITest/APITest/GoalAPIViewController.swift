//
//  GoalAPIViewController.swift
//  erooja
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaNetwork
import EroojaCommon

public class GoalAPIViewController: BaseViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchModel = GoalSearchModel(goalFilterBy: "TITLE", keyword: "test", fromDt: "2020-04-22T00:18:26", toDt: "2020-05-02T00:00:00", jobInterestIds: [1, 2], goalSortBy: "TITLE", direction: "ASC", size: 10, page: 0)
        
        EroojaAPIRequest().requestSearchGoal(searchModel: searchModel, token: "Test Token", completion: { result in
            
        })
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

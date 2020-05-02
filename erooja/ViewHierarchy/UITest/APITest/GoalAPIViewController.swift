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
    @IBOutlet weak var tfFilterBy: UITextField!
    @IBOutlet weak var tfKeyword: UITextField!
    @IBOutlet weak var tfFromDt: UITextField!
    @IBOutlet weak var tfToDt: UITextField!
    @IBOutlet weak var tfInterestIds: UITextField!
    @IBOutlet weak var tfDirection: UITextField!
    @IBOutlet weak var tfSort: UITextField!
    @IBOutlet weak var tfSize: UITextField!
    @IBOutlet weak var tfPage: UITextField!
    @IBOutlet weak var tfAccessToken: UITextField!
    
    @IBOutlet weak var searchGoalLogView: UITextView!
    
    @IBAction func onClickSearchGoal(_ sender: UIButton) {
        var interests: [Int] = [Int]()
        for char in tfInterestIds.text!.split(separator: ",") {
            interests.append(Int(String(char))!)
        }
        
        let searchModel = GoalSearchModel(goalFilterBy: tfFilterBy.text!, keyword: tfKeyword.text!, fromDt: tfFromDt.text!, toDt: tfToDt.text!, jobInterestIds: interests, goalSortBy: tfDirection.text!, direction: tfSort.text!, size: Int(tfSize.text!)!, page: Int(tfPage.text!)!)
        
        EroojaAPIRequest().requestSearchGoal(searchModel: searchModel, token: tfAccessToken.text!, completion: { result in
            
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchModel = GoalSearchModel(goalFilterBy: "TITLE", keyword: "test", fromDt: "2020-04-22T00:18:26", toDt: "2020-05-02T00:00:00", jobInterestIds: [1, 2], goalSortBy: "TITLE", direction: "ASC", size: 10, page: 0)
        
//        EroojaAPIRequest().requestCreateGoal(createGoalModel: nil, token: nil, completion: { result in
//
//        })
        
        EroojaAPIRequest().requestSearchGoal(searchModel: searchModel, token: "Test Token", completion: { result in
            
        })
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

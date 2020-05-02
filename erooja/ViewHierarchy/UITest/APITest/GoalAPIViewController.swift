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
    @IBOutlet weak var tfGoalID: UITextField!
    
    @IBOutlet weak var searchGoalLogView: UITextView!
    
    // Create Goal
    @IBOutlet weak var tfCreateGoalTitle: UITextField!
    @IBOutlet weak var tfCreateGoalDesc: UITextField!
    @IBOutlet weak var tfCreateToDoTitle: UITextField!
    @IBOutlet weak var tfCreateGoalToken: UITextField!
    @IBOutlet weak var lblNumberOfToDo: UILabel!
    @IBOutlet weak var createGoalLogView: UITextView!
    
    private var todoCount = 0
    
    @IBAction func didChangeValue(_ sender: UIStepper) {
        self.view.endEditing(true)
        self.lblNumberOfToDo.text = "Number of ToDo : \(sender.value)"
        todoCount = Int(sender.value)
    }
    
    @IBAction func onClickCreateGoal(_ sender: UIButton) {
        self.view.endEditing(true)
        var todoList = [ToDoRequestModel]()
        for index in 0..<todoCount {
            todoList.append(ToDoRequestModel(content: "\(tfCreateToDoTitle.text!)\(index)", priority: index))
        }
        
        let model = GoalCreateRequestModel(title: tfCreateGoalTitle.text!, description: tfCreateGoalDesc.text!, isDateFixed: true, endDt: "2020-06-20T00:00:00", interestIdList: [1, 2], todoList: todoList)
        if let token = tfCreateGoalToken.text {
            EroojaAPIRequest().requestCreateGoal(createGoalModel: model, token: token, completion: { result in
                switch result {
                case .success(let item):
                    var debugLogText = ""
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                        
                        let goalItem = try decoder.decode(GoalSearchResponseModel.self, from: jsonData)
                        debugLogText += "createDt : \(goalItem.createDt)\n"
                        debugLogText += "updateDt : \(goalItem.updateDt)\n"
                        debugLogText += "id : \(goalItem.id)\n"
                        debugLogText += "title : \(goalItem.title)\n"
                        debugLogText += "description : \(goalItem.description)\n"
                        debugLogText += "joinCount : \(goalItem.joinCount)\n"
                        debugLogText += "isEnd : \(goalItem.isEnd)\n"
                        debugLogText += "isDateFixed : \(goalItem.isDateFixed)\n"
                        debugLogText += "startDt : \(goalItem.startDt)\n"
                        debugLogText += "endDt : \(goalItem.endDt)\n"
                    } catch {
                        if let messageData = item as? NSDictionary {
                            debugLogText = ""
                            let message: String = (messageData["message"] as? String) ?? ""
                            debugLogText += "\(messageData["status"])\n"
                            debugLogText += "\(message.removingPercentEncoding)\n"
                            debugLogText += "JSON Decode Error"
                            break
                        }
                    }
                    self.createGoalLogView.text = debugLogText
                case .failure(_):
                    self.createGoalLogView.text = "URLRequestError... Please Try Again"
                }
            })
        }
    }
    
    @IBAction func onClickSearchByGoalID(_ sender: UIButton) {
        self.view.endEditing(true)
        EroojaAPIRequest().requestSearchGoalByID(goalId: tfGoalID.text!, completion: { result in
            //GoalSearchResponseModel
            switch result {
            case .success(let item):
                var debugLogText = ""
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                    
                    let goalItem = try decoder.decode(GoalSearchResponseModel.self, from: jsonData)
                    debugLogText += "createDt : \(goalItem.createDt)\n"
                    debugLogText += "updateDt : \(goalItem.updateDt)\n"
                    debugLogText += "id : \(goalItem.id)\n"
                    debugLogText += "title : \(goalItem.title)\n"
                    debugLogText += "description : \(goalItem.description)\n"
                    debugLogText += "joinCount : \(goalItem.joinCount)\n"
                    debugLogText += "isEnd : \(goalItem.isEnd)\n"
                    debugLogText += "isDateFixed : \(goalItem.isDateFixed)\n"
                    debugLogText += "startDt : \(goalItem.startDt)\n"
                    debugLogText += "endDt : \(goalItem.endDt)\n"
                } catch {
                    if let messageData = item as? NSDictionary {
                        debugLogText = ""
                        let message: String = (messageData["message"] as? String) ?? ""
                        debugLogText += "\(messageData["status"])\n"
                        debugLogText += "\(message.removingPercentEncoding)\n"
                        debugLogText += "JSON Decode Error"
                        break
                    }
                }
                self.searchGoalLogView.text = debugLogText
            case .failure(_):
                self.searchGoalLogView.text = "URLRequestError... Please Try Again"
            }
        })
    }
    
    @IBAction func onClickSearchGoal(_ sender: UIButton) {
        self.view.endEditing(true)
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
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//
//  JobAPIViewController.swift
//  erooja
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import EroojaNetwork

public class JobAPIViewController: BaseViewController {
    
    @IBOutlet weak var tfAccessToken: UITextField!
    @IBOutlet weak var tfJobGroupID: UITextField!
    @IBOutlet weak var tfJobSingleId: UITextField!
    
    @IBOutlet weak var jobLogView: UITextView!
    
    @IBAction func onClickFetchJobGroupList(_ sender: UIButton) {
        if let token = tfAccessToken.text, !token.isEmpty {
            self.fetchJobGroupList(token: token)
        } else {
            self.jobLogView.text = "Please enter your valid Access Token."
        }
    }
    
    @IBAction func onClickFetchJobSingleItemList(_ sender: UIButton) {
        if !(tfAccessToken.text ?? "").isEmpty && !(tfJobGroupID.text ?? "").isEmpty {
            self.fetchJobListFromGroupId(jobGroupId: tfJobGroupID.text!, token: tfAccessToken.text!)
        } else {
            self.jobLogView.text = "Please enter your valid Access Token and Job Group ID."
        }
    }
    
    @IBAction func onClickFetchJobSingleItem(_ sender: UIButton) {
        if let id = tfJobSingleId.text, !id.isEmpty {
            EroojaAPIRequest().fetchJobItemFromId(jobItemId: id, completion: { result in
                switch result {
                case .success(let item):
                    var debugLogText = ""
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                        
                        let jobItem = try decoder.decode(JobInterest.self, from: jsonData)
                        debugLogText += "id : \(jobItem.id)\n"
                        debugLogText += "name : \(jobItem.name)\n"
                        debugLogText += "jobGroupId : \(jobItem.jobGroupId)"
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
                    self.jobLogView.text = debugLogText
                case .failure(_):
                    self.jobLogView.text = "URLRequestError... Please Try Again"
                }
            })
        } else {
            self.jobLogView.text = "Please enter your Job Single Item ID."
        }
    }
    
    fileprivate func fetchJobGroupList(token: String) {
        EroojaAPIRequest().fetchJobGroupList(token: token, completion: { result in
            switch result {
            case .success(let list):
                if let data = (list as? [NSDictionary]) {
                    var debugLogText = ""
                    for jobGroup in data {
                        do {
                            let decoder = JSONDecoder()
                            let jsonData = try JSONSerialization.data(withJSONObject: jobGroup, options: .prettyPrinted)
                            
                            let jobGroupInfo = try decoder.decode(JobTypeModel.self, from: jsonData)
                            debugLogText += "id : \(jobGroupInfo.id) name : \(jobGroupInfo.name)\n"
                        } catch {
                            if let messageData = list as? NSDictionary {
                                debugLogText = ""
                                let message: String = (messageData["message"] as? String) ?? ""
                                debugLogText += "\(messageData["status"])\n"
                                debugLogText += "\(message.removingPercentEncoding)\n"
                                debugLogText += "JSON Decode Error"
                                break
                            }
                        }
                    }
                    self.jobLogView.text = debugLogText
                }
            case .failure(_):
                self.jobLogView.text = "URLRequestError... Please Try Again"
            }
        })
    }
    
    fileprivate func fetchJobListFromGroupId(jobGroupId: String, token: String) {
        EroojaAPIRequest().fetchJobListByJobGroup(jobGroupId: jobGroupId, token: token, completion: { result in
            switch result {
            case .success(let list):
                var debugLogText = ""
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
                    
                    let jobGroupInfo = try decoder.decode(JobGroup.self, from: jsonData)
                    debugLogText += "id : \(jobGroupInfo.id) name : \(jobGroupInfo.name)\n"
                    
                    for jobInterest in jobGroupInfo.jobInterests {
                        debugLogText += "\(jobInterest.id) / \(jobInterest.name)\n"
                    }
                } catch {
                    if let messageData = list as? NSDictionary {
                        debugLogText = ""
                        let message: String = (messageData["message"] as? String) ?? ""
                        debugLogText += "\(messageData["status"])\n"
                        debugLogText += "\(message.removingPercentEncoding)\n"
                        debugLogText += "JSON Decode Error"
                        break
                    }
                }
                self.jobLogView.text = debugLogText
            case .failure(_):
                self.jobLogView.text = "URLRequestError... Please Try Again"
            }
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

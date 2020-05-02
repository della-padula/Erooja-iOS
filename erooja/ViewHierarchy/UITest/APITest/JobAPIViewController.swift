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
        } else {
            self.jobLogView.text = "Please enter your valid Access Token."
        }
    }
    
    @IBAction func onClickFetchJobSingleItem(_ sender: UIButton) {
        
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

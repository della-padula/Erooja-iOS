//
//  APITestViewController.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import EroojaNetwork

public class APITestViewController: BaseViewController {
    @IBOutlet weak var apiListView: UITableView!
    public var viewModel: APITestViewModel?
    private var apiTestItems = [EroojaAPIType]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.apiListView.delegate = self
        self.apiListView.dataSource = self
        self.apiListView.tableFooterView = UIView()
        
        bindViewModel()
        loadAPIItems()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.apiTestItems.bind({ (list) in
                DispatchQueue.main.async {
                    self.apiTestItems = list
                    self.apiListView.reloadData()
                }
            })
        }
    }
    
    private func loadAPIItems() {
        viewModel?.setAPIItemsToView()
    }
}

extension APITestViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiTestItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = apiTestItems[indexPath.row].rawValue
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testType = apiTestItems[indexPath.row]
        switch testType {
        case .TokenAPI:
            let vc = storyboard?.instantiateViewController(withIdentifier: "apiTestTokenVC") as! AccessTokenViewController
            navigationController?.pushViewController(vc, animated: true)
        case .memberAPI:
            let vc = storyboard?.instantiateViewController(withIdentifier: "apiTestUserInfoVC") as! UserAPIViewController
            navigationController?.pushViewController(vc, animated: true)
        case .jobInterestAPI:
            let vc = storyboard?.instantiateViewController(withIdentifier: "apiTestJobInfoVC") as! JobAPIViewController
            navigationController?.pushViewController(vc, animated: true)
        case .goalAPI:
            let vc = storyboard?.instantiateViewController(withIdentifier: "apiTestGoalVC") as! GoalAPIViewController
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

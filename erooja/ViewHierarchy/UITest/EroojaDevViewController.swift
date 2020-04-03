//
//  UITestViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon
import EroojaNetwork
import EroojaSharedBase

class UITestViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum EroojaType: String, CaseIterable {
        case onboard       = "온보딩"
        case signup        = "회원가입"
        case mypage        = "마이페이지"
        case main          = "메인"
        case nowGoal       = "진행중인 목표"
        case search        = "탐색"
        case addGoal       = "목표 추가"
        case peopleProfile = "타 계정페이지"
        case guest         = "게스트 로직"
        case apiTest       = "Dev - API Test"
    }
    
    private let types = EroojaType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView()
    }

}

extension UITestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EroojaDevCell", for: indexPath) as! UITestTableViewCell
        cell.lblTitle.text = types[indexPath.row].rawValue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        switch type {
        case .signup:
            let vc = SignUpViewController()
            present(vc, animated: true, completion: nil)
        case .onboard:
            let vc = OnboardViewController()
            present(vc, animated: true, completion: nil)
        case .search:
            let vc = SearchViewController()
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
}


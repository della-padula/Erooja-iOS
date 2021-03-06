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
    
    public var viewModel: UITestViewModel?
    
    private var types = [EroojaType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        showAllCustomFonts()
        bindViewModel()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        loadMenuItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func showAllCustomFonts() {
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.menuItems.bind({ (menuItems) in
                DispatchQueue.main.async {
                    self.types = menuItems
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func loadMenuItems() {
        ELog.debug("loadMenuItems")
        viewModel?.setDevMenuItemsToView()
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
        ELog.debug("Selected : \(type.rawValue)")
        
        var vc: UIViewController?
        
        switch type {
        case .signup:
            vc = SignUpViewController()
        case .onboard:
            vc = OnboardViewController()
        case .login:
            vc = LoginViewController()
        case .goalDetail:
//            let dst = GoalDetailViewController()
            let dst = DetailGoalViewController()
            dst.viewModel = DetailGoalViewModel()
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        case .addGoal:
            let dst = CreateGoalViewController()
            dst.viewModel = CreateGoalViewModel()
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        case .search:
            let dst = SearchViewController()
            dst.viewModel = SearchViewModel()
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        case .modalViewTest:
            vc = EUIModalViewController()
            (vc as! EUIModalViewController).delegate = self
        case .dragTable:
//            let dragVC = DraggableTableViewController()
//            dragVC.viewModel = DraggableTableViewModel()
//            dragVC.modalPresentationStyle = .fullScreen
//            present(dragVC, animated: true, completion: nil)
            break
        case .apiTest:
            let dst = storyboard?.instantiateViewController(withIdentifier: "apiTestVC") as! APITestViewController
            dst.viewModel = APITestViewModel()
            dst.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        default:
            break
        }
        if let nextVC = vc {
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true, completion: nil)
        }
    }
    
}

extension UITestViewController: EUIModalViewDelegate {
    func onClickBottomButton() {
        ELog.debug("Modal VC - Bottom Button Clicked")
    }
    
    func modalViewController() -> (String, String, String, ModalType) {
        let title = "목표를 80% 달성했습니다!"
        let content = "열심히 달려온 당신, 칭찬의 박수 짝짝짝.\n새로운 목표에서 리스트를 시작해보세요."
        let buttonTitle = "새로운 목표 둘러보기"
        
        return (title, content, buttonTitle, .flagWithHands)
//        return (title, content, buttonTitle, .goal)
//        return (title, content, buttonTitle, .flag)
    }
}

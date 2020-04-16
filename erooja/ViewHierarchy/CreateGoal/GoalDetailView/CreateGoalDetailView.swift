//
//  CreateGoalThirdCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import NotificationCenter
import EroojaCommon
import EroojaUI

enum DetailListSection: Int {
    case result = 0
    case input = 1
}

public class CreateGoalDetailView: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    public var delegate: CreateGoalHeaderViewDelegate?
    public var viewModel = CreateGoalDetailViewModel()
    
    private var detailList = [String]()
    private var keyboardSize: CGSize?
    
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
        registerForKeyboardNotifications()
        detailTableView.tableFooterView = UIView()
        detailTableView.separatorStyle = .none
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
        let itemNibName = UINib(nibName: "GoalDetailItemCell", bundle: nil)
        let inputNibName = UINib(nibName: "GoalDetailItemInputCell", bundle: nil)
        
        detailTableView.register(inputNibName, forCellReuseIdentifier: "goalDetailInputCell")
        detailTableView.register(itemNibName, forCellReuseIdentifier: "goalDetailItemCell")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onClickRightButton(_:)),
                                               name: NSNotification.Name("RightButtonClicked"),
                                               object: nil)
    }
    
    fileprivate func bindViewModel() {
        viewModel.detailList.bind({ (detailList) in
            DispatchQueue.main.async {
                self.detailList = detailList
                self.delegate?.rightButton(at: .second, active: self.detailList.count > 0)
                self.detailTableView.reloadSections(IndexSet(arrayLiteral: DetailListSection.result.rawValue), with: .none)
                self.tableViewLayoutSetUpperKeyboard()
            }
        })
    }
    
    private func tableViewLayoutSetUpperKeyboard() {
        var contentInsets:UIEdgeInsets
        var topPadding: CGFloat?
        var bottomPadding: CGFloat?
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top
            bottomPadding = (window?.safeAreaInsets.bottom ?? 0) + 20
        }
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.keyboardSize!.height + (bottomPadding ?? 0), right: 0.0);
        } else {
            contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.keyboardSize!.width, right: 0.0);
        }
        
        self.detailTableView.contentInset = contentInsets
        self.detailTableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .none, animated: false)
        self.detailTableView.scrollIndicatorInsets = self.detailTableView.contentInset
    }
    
    @objc func keyboardWasShown (notification: NSNotification) {
        ELog.debug(message: "keyboard was shown")
        let info = notification.userInfo
        if let value = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            self.keyboardSize = value.cgRectValue.size
            self.tableViewLayoutSetUpperKeyboard()
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    public func onClickRightButton(_ notification: Notification) -> Void {
        ELog.debug(message: "Save Detail List to Property")
        CreateGoalDynamicProperty.detailGoalList = detailList
        CreateGoalDynamicProperty.printPropertyInfo()
    }
}

extension CreateGoalDetailView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case DetailListSection.result.rawValue:
            return self.detailList.count
        case DetailListSection.input.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case DetailListSection.result.rawValue:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailItemCell")
                as! GoalDetailItemCell
            itemCell.title = self.detailList[indexPath.row]
            return itemCell
        case DetailListSection.input.rawValue:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "goalDetailInputCell")
                as! GoalDetailItemInputCell
            inputCell.delegate = self
            inputCell.selectionStyle = .none
            return inputCell
        default:
            return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            // Call edit action
//            // Reset state
//            self.tableView.isEditing = false
//            self.viewModel?.tableListItem.valueForBind.remove(at: indexPath.row)
            success(true)
        })
        
        if indexPath.section == DetailListSection.result.rawValue {
            return UISwipeActionsConfiguration(actions:[deleteAction])
        } else {
            return nil
        }
    }
}

extension CreateGoalDetailView: GoalDetailInputDelegate {
    public func returnKeyEvent(_ textField: UITextField, content: String?) {
        let strongContent = content ?? ""
        if strongContent.isEmpty {
            ELog.debug(message: "세부 항목을 입력해주세요.")
        } else {
            viewModel.append(item: strongContent)
        }
    }
}


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

public class CreateGoalFourthCell: UICollectionViewCell {
    @IBOutlet weak var modifyAvailableBtn: UIButton!
    @IBOutlet weak var modifyUnavailableBtn: UIButton!
    
    @IBOutlet weak var modifyAvailableLabel: UILabel!
    @IBOutlet weak var modifyUnavailableLabel: UILabel!
    
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBAction func onClickCalendar(_ sender: Any) {
        NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "CalendarButton"),
        object: nil)
    }
    
    @IBAction func onClickSwitchButton(_ sender: UIButton) {
        self.setAvailableButton(tag: sender.tag)
    }
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self,
        selector: #selector(didReceiveTestNotification(_:)),
        name: NSNotification.Name("CGDatePickerSelected"),
        object: nil)
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = format.string(from: Date())
        
        lblStartDate.text = formattedDate
        
        setFourthLayout()
    }
    
    private func setFourthLayout() {
        setAvailableButton(tag: 0)
    }
    
    private func setAvailableButton(tag: Int) {
        if tag == 0 {
            setModifyAvailableButton(isActive: true)
            setModifyUnavailableButton(isActive: false)
        } else {
            setModifyAvailableButton(isActive: false)
            setModifyUnavailableButton(isActive: true)
        }
    }
    
    private func setModifyAvailableButton(isActive: Bool) {
        modifyAvailableBtn.layer.cornerRadius = 8
        modifyAvailableBtn.layer.borderColor = isActive ? EroojaColorSet.shared.orgDefault400s.cgColor : EroojaColorSet.shared.gray500s.cgColor
        modifyAvailableBtn.layer.borderWidth = 1
        modifyAvailableLabel.font = .AppleSDSemiBold15P
        modifyAvailableLabel.textColor = isActive ? EroojaColorSet.shared.orgDefault400s : EroojaColorSet.shared.gray300s
    }
    
    private func setModifyUnavailableButton(isActive: Bool) {
        modifyUnavailableBtn.layer.cornerRadius = 8
        modifyUnavailableBtn.layer.borderColor = isActive ? EroojaColorSet.shared.orgDefault400s.cgColor : EroojaColorSet.shared.gray500s.cgColor
        modifyUnavailableBtn.layer.borderWidth = 1
        modifyUnavailableLabel.font = .AppleSDSemiBold15P
        modifyUnavailableLabel.textColor = isActive ? EroojaColorSet.shared.orgDefault400s : EroojaColorSet.shared.gray300s
    }
     
    @objc func didReceiveTestNotification(_ notification: Notification) {
        guard let selectedDate: String = notification.userInfo?["SelectedDate"] as? String else { return }
        
        print("SelectedDate :", selectedDate)
        lblEndDate.text = selectedDate
    }

    
    
}

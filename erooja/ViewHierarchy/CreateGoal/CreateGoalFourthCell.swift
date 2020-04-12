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
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBAction func onClickCalendar(_ sender: Any) {
        NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "CalendarButton"),
        object: nil)
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
    }
     
    @objc func didReceiveTestNotification(_ notification: Notification) {
        guard let selectedDate: String = notification.userInfo?["SelectedDate"] as? String else { return }
        
        print("SelectedDate :", selectedDate)
        lblEndDate.text = selectedDate
    }

    
    
}

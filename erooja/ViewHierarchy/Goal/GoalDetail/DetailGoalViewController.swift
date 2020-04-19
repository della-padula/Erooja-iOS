//
//  DetailGoalViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/18.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

class DetailGoalViewController: BaseViewController {
    @IBOutlet weak var detailTopSectionView: UIView!
    @IBOutlet weak var navigationBar: EUIHeaderView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var detailTopDateLabel: UILabel!
    @IBOutlet weak var detailTopTitleLabel: UILabel!
    @IBOutlet weak var detailTopContentLabel: UILabel!
    @IBOutlet weak var downArrowButton: UIView!
    @IBOutlet weak var downArrowButtonImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var detailTopDateLabelTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var detailTopTitleLabelTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var detailTopContentLabelTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var detailTopViewHeight: NSLayoutConstraint!
    @IBOutlet weak var downArrowButtonTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var downArrowButtonHeight: NSLayoutConstraint!
    
    private let saveButton = EShadowRoundButton()
    private let detailToDoListView = UIStackView()
    private var isSpreaded: Bool = false
    
    @IBAction func onClickSpreadButton(_ sender: UIButton) {
        isSpreaded = !isSpreaded
        self.detailTopContentLabel.numberOfLines = self.isSpreaded ? 0 : 3

        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })

        downArrowButtonImage.image = isSpreaded ? .goalDetailUpArrow : .goalDetailDownArrow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TEMP
        detailTopTitleLabel.text = "애프터이펙트 익스프레션 학습을 통한 모션그래픽 제작"
        detailTopContentLabel.text = "포트폴리오 진행하기는 나의 부족한 포트폴리오를 매년 4월, 11월 경 열리는 펠로우십 과제를 준비하는 였는가더보기 인간은 때에, 청춘을 피고, 아니다. 있음으로써 밥을 인류의 것이다. 찾아다녀도, 뜨거운지라, 낙원을 이상의 역사를 피어나기 봄바람이다. 긴지라 위하여서, 인생을 그와 위하여, 봄바람이다. 대한 만천하의 황금시대의 설레는 살았으며, 같으며, 현저하게 운다. 같은 우리 커다란 힘차게 이상이 인간은 품으며, 별과 칼이다. 길을 있을 인생에 품으며, 뛰노는 스며들어 청춘의 무엇이 얼마나 봄바람이다. 꽃이 새 있는 이 대고, 위하여, 옷을 그들은 힘차게 말이다.\n\n꽃이 전인 밥을 풀이 무엇이 때문이다. 그러므로 그것은 있음으로써 있는 끓는다. 얼마나 밝은 사는가 살았으며, 살 우리는 가지에 사막이다. 밝은 대한 구하지 구할 품에 우리 찾아 부패뿐이다. "
        
        setViewLayout()
    }

    private func setViewLayout() {
        setStatusBarBackground()
        setNavigationBar()
        setTopSectionView()
        setStackView()
        
        self.view.addSubview(saveButton)
        
        saveButton.title = "변경 저장"
        saveButton.backgroundColor = EroojaColorSet.shared.white100
        saveButton.titleColor = EroojaColorSet.shared.orgDefault400
        saveButton.titleFont = .SpoqaBold17P
        saveButton.shadowWidth = 10
        saveButton.shadowVerticalOffset = 10
        
        // MARK: TEMP Shadow Color
        saveButton.shadowColor = EroojaColorSet.shared.gray700
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.3).isActive = true
        saveButton.heightAnchor.constraint(equalTo: saveButton.widthAnchor, multiplier: 0.5).isActive = true
        saveButton.topAnchor.constraint(equalTo: detailToDoListView.bottomAnchor, constant: 20).isActive = true
    }
    
    fileprivate func setStackView() {
        // DetailGoalToDoItemView
        
        for _ in 0..<10 {
            detailToDoListView.addArrangedSubview(DetailGoalToDoItemView())
        }
        
        self.view.addSubview(detailToDoListView)
        
        detailToDoListView.distribution = .equalSpacing
        detailToDoListView.translatesAutoresizingMaskIntoConstraints = false
        detailToDoListView.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 20).isActive = true
        detailToDoListView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        detailToDoListView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    }
    
    fileprivate func setTopSectionView() {
        detailTopSectionView.clipsToBounds = true
        detailTopSectionView.layer.cornerRadius = 20
        detailTopSectionView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        detailTopSectionView.backgroundColor = EroojaColorSet.shared.orgDefault400
        
        detailTopTitleLabel.font = .SpoqaBold20P
        detailTopDateLabel.font = .SpoqaLight14P
        detailTopContentLabel.font = .SpoqaRegular14P
        detailTopDateLabel.textColor = EroojaColorSet.shared.white100
        detailTopTitleLabel.textColor = EroojaColorSet.shared.white100
        detailTopContentLabel.textColor = EroojaColorSet.shared.white100
        detailTopContentLabel.setLinespace(spacing: 4)
        
        ELog.debug(message: "Top Detail Content Label Height : \(self.detailTopContentLabel.frame.height)")
        ELog.debug(message: "Top Section View Height : \(self.detailTopViewHeight.constant)")
    }
    
    fileprivate func setNavigationBar() {
        navigationBar.barOptions = [.backButton, .rightSecondButton]
        navigationBar.setRightButtonColor(position: .second, colorActive: EroojaColorSet.shared.white100, colorInActive: EroojaColorSet.shared.white100)
        navigationBar.delegate = self
        navigationBar.rightSecondButtonType = .image
        navigationBar.setBackButtonImage(image: .goalDetailBackArrow)
        navigationBar.setRightButtonImage(position: .second, image: .goalDetailMenu)
        
        navigationBar.backgroundColor = EroojaColorSet.shared.orgDefault400
    }
    
    fileprivate func setStatusBarBackground() {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let safeAreaBGView = UIView()
            self.view.addSubview(safeAreaBGView)
            safeAreaBGView.backgroundColor = EroojaColorSet.shared.orgDefault400
            safeAreaBGView.translatesAutoresizingMaskIntoConstraints = false
            safeAreaBGView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            safeAreaBGView.heightAnchor.constraint(equalToConstant: topPadding!).isActive = true
            safeAreaBGView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            safeAreaBGView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }
}

extension DetailGoalViewController: EUINavigationBarDelegate {
    public func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didChangeTextField(_ textField: EroojaTextField, text: String?) {
        
    }
    
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        
    }
}

extension DetailGoalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

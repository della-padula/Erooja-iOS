//
//  ActivityIndicatorView.swift
//  EroojaSharedBase
//
//  Created by 김태인 on 2020/03/31.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaUI

public protocol ActivityIndicatorDimViewDelegate: class {
    func willShow(dimView: ActivityIndicatorView.ActivityIndicatorDimView)
    func didShow(dimView: ActivityIndicatorView.ActivityIndicatorDimView)
    func willHide(dimView: ActivityIndicatorView.ActivityIndicatorDimView)
    func didHide(dimView: ActivityIndicatorView.ActivityIndicatorDimView)
}

public enum ActivityIndicatorState: Int {
    case initialized
    case loading
    case progressing
    case cancelled
    case finished
    case failed
    
    var image: UIImage? {
        switch self {
        case .finished:
//            return UIImage(named: "progress_bar_ok", in: TalkSharedBase.bundle, compatibleWith: nil)
            return nil
        case .failed:
//            return UIImage(named: "progress_bar_fail", in: TalkSharedBase.bundle, compatibleWith: nil)
            return nil
        default:
            return nil
        }
    }
    
    var isRemovable: Bool {
        switch self {
        case .cancelled, .finished, .failed:
            return true
        default:
            return false
        }
    }
    
    public var name: String {
        switch self {
        case .initialized:
            return "initialized"
        case .loading:
            return "loading"
        case .progressing:
            return "progressing"
        case .cancelled:
            return "cancelled"
        case .finished:
            return "finished"
        case .failed:
            return "failed"
        }
    }
}

public final class ActivityIndicatorView: UIView, CAAnimationDelegate {
    static let animationDuration: Double = 0.1
    static let animationDurationDown: Double = 0.2
    static let timerInterval: Double = 1.0
    static let initialAlphaValue: CGFloat = 0.5
    static let indicatorWidth: CGFloat = 77
    static let textMaxWidth: CGFloat = 280
    static let defaultFrame: CGRect = CGRect(x: 0, y: 0, width: ActivityIndicatorView.indicatorWidth, height: ActivityIndicatorView.indicatorWidth)
    static let bottomPadding: CGFloat = 40
    
    final class ActivityIndicatorImageView: UIImageView {
        private var progressImages: [UIImage] = []
        private let progressNumberLabel: UILabel = UILabel()
        private let progressIndicatorClippingView: UIView = UIView()
        private let progressIndicatorImageView: UIImageView = UIImageView()
        private var maxImageIndex: Int = 0
    }
        
    public final class ActivityIndicatorDimView: UIView {
        weak var delegate: ActivityIndicatorDimViewDelegate?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            autoresizingMask = [.flexibleHeight, .flexibleWidth]
            backgroundColor = .black
            alpha = 0
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func willShow() {
            delegate?.willShow(dimView: self)
        }
        
        func didShow() {
            delegate?.didShow(dimView: self)
        }
        
        func willHide() {
            delegate?.willHide(dimView: self)
        }
        
        func didHide() {
            delegate?.didHide(dimView: self)
        }
    }
    
    public static let activityIndicatorView: ActivityIndicatorView = ActivityIndicatorView(frame: ActivityIndicatorView.defaultFrame)
    
}

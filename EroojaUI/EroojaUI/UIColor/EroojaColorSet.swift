//
//  EroojaColorSet.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

@objc
public enum EroojaUserInterfaceStyle: Int {
    case dynamic
    case light
    case dark
    
    @available(iOS 12.0, *)
    func convertToUIKitStyle() -> UIUserInterfaceStyle {
        switch self {
        case .dynamic: return .unspecified
        case .light: return .light
        case .dark: return .dark
        }
    }
}

public class EroojaColorSet: NSObject {
    public static let shared = EroojaColorSet(style: .light)
    
    let style: EroojaUserInterfaceStyle
    
    private init(style: EroojaUserInterfaceStyle = .dynamic) {
        self.style = style
        super.init()
    }
    //3C1E1E
    public var kakaoYellow000s: UIColor { color("#F7E317", 1, "#F7E317", 1)}
    public var kakaoBrown000s: UIColor { color("#3C1E1E", 1, "#1EC800", 1)}
    public var naverGreen000s: UIColor { color("#1EC800", 1, "#F7E317", 1)}
    
    public var orgDefault400s: UIColor { color("#f3590f", 1, "#f3590f", 1) }
    public var subDefault400s: UIColor { color("#38bbd0", 1, "#38bbd0", 1) }
    
    public var gray100s: UIColor { color("#F5F5F5", 1, "#F5F5F5", 1) }
    public var gray200s: UIColor { color("#EAEAEA", 1, "#EAEAEA", 1) }
    public var gray300s: UIColor { color("#e0e0e0", 1, "#e0e0e0", 1) }
    public var gray400s: UIColor { color("#bdbdbd", 1, "#bdbdbd", 1) }
    public var gray500s: UIColor { color("#757575", 1, "#757575", 1) }
    public var gray600s: UIColor { color("#424242", 1, "#424242", 1) }
    public var gray700s: UIColor { color("#333333", 1, "#333333", 1) }
    public var gray800s: UIColor { color("#191919", 1, "#191919", 1) }
    
    public var black100s: UIColor { color("#000000", 1, "#000000", 1) }
    public var white100s: UIColor { color("#ffffff", 1, "#ffffff", 1) }
    
    public var subLight100s: UIColor { color("#c8ecf2", 1, "#c8ecf2", 1) }
    public var subLight300s: UIColor { color("#f6f6ff", 1, "#f6f6ff", 1) }
    public var subLight400s: UIColor { color("#fbfbff", 1, "#fbfbff", 1) }
    
    public var error000s: UIColor { color("#D32F2F", 1, "#D32F2F", 1) }
    public var safe000s: UIColor { color("#4CAF50", 1, "#4CAF50", 1) }
    
    
    private func color(_ lightString: String,
                       _ lightAlpha: CGFloat,
                       _ darkString: String,
                       _ darkAlpha: CGFloat) -> UIColor {
        
        let light = UIColor(hex: lightString, alpha: lightAlpha)
//        let dark = UIColor(hex: darkString, alpha: darkAlpha)
        
        switch style {
        case .light:
            return light
        case .dark:
            // Dark 모드를 지원하지 않으므로 모두 Light로 반환한다. (추후 수정 가능)
            return light
        case .dynamic:
            return light
        }
    }
}

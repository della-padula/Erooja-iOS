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
    
    public var org800s: UIColor { color("#7c2d06", 1, "#7c2d06", 1) }
    public var org700s: UIColor { color("#ad3e09", 1, "#ad3e09", 1) }
    public var orgPressed600s: UIColor { color("#c5470a", 1, "#c5470a", 1) }
    public var orgPressed500s: UIColor { color("#dd4f0b", 1, "#dd4f0b", 1) }
    public var orgDefault400s: UIColor { color("#f3590f", 1, "#f3590f", 1) }
    public var orgHover300s: UIColor { color("#f57b40", 1, "#f57b40", 1) }
    public var orgHover200s: UIColor { color("#f89c70", 1, "#f89c70", 1) }
    public var org100s: UIColor { color("#f9ad88", 1, "#f9ad88", 1) }
    public var org000s: UIColor { color("#fbcfb9", 1, "#fbcfb9", 1) }
    
    public var sub800s: UIColor { color("#15505a", 1, "#15505a", 1) }
    public var sub700s: UIColor { color("#1f7583", 1, "#1f7583", 1) }
    public var subPressed600s: UIColor { color("#248898", 1, "#248898", 1) }
    public var subPressed500s: UIColor { color("#299aac", 1, "#299aac", 1) }
    public var subDefault400s: UIColor { color("#38bbd0", 1, "#38bbd0", 1) }
    public var subHover300s: UIColor { color("#61c9da", 1, "#61c9da", 1) }
    public var subHover200s: UIColor { color("#76d0df", 1, "#76d0df", 1) }
    public var sub100s: UIColor { color("#9fdee8", 1, "#9fdee8", 1) }
    public var sub000s: UIColor { color("#c8ecf2", 1, "#c8ecf2", 1) }
    
    public var grayBg700s: UIColor { color("#F5F5F5", 1, "#F5F5F5", 1) }
    public var gray600s: UIColor { color("#EAEAEA", 1, "#EAEAEA", 1) }
    public var gray500s: UIColor { color("#e0e0e0", 1, "#e0e0e0", 1) }
    public var gray400s: UIColor { color("#bdbdbd", 1, "#bdbdbd", 1) }
    public var gray300s: UIColor { color("#757575", 1, "#757575", 1) }
    public var gray200s: UIColor { color("#424242", 1, "#424242", 1) }
    public var gray100s: UIColor { color("#333333", 1, "#333333", 1) }
    public var gray000s: UIColor { color("#000000", 1, "#000000", 1) }
    
    public var whiteBg000s: UIColor { color("#ffffff", 1, "#ffffff", 1) }
    
    public var error000s: UIColor { color("#D32F2F", 1, "#D32F2F", 1) }
    public var warning000s: UIColor { color("#F9A825", 1, "#F9A825", 1) }
    public var safe000s: UIColor { color("#4CAF50", 1, "#4CAF50", 1) }
    public var active000s: UIColor { color("#0091EA", 1, "#0091EA", 1) }
    
    
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

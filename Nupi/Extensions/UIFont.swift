//
//  UIFont.swift
//  Nupi
//
//  Created by Dana Lim on 1/9/25.
//

import UIKit

enum FontName: String {
    case jejuDoldam = "EF_jejudoldam"
    case wantedSansSemiBold = "WantedSans-SemiBold"
    case wantedSansMedium = "WantedSans-Medium"
    case wantedSansRegular = "WantedSans-Regular"
}

extension UIFont {
    // logo1: EF_jejudoldam, 32pt
    @nonobjc class var logo1: UIFont {
        return UIFont(name: FontName.jejuDoldam.rawValue, size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .regular)
    }
    
    // logo2: EF_jejudoldam, 38pt
    @nonobjc class var logo2: UIFont {
        return UIFont(name: FontName.jejuDoldam.rawValue, size: 38) ?? UIFont.systemFont(ofSize: 38, weight: .regular)
    }
    
    // heading1: WantedSans-SemiBold, 21pt
    @nonobjc class var heading1: UIFont {
        return UIFont(name: FontName.wantedSansSemiBold.rawValue, size: 21) ?? UIFont.boldSystemFont(ofSize: 21)
    }
    
    // heading2: WantedSans-SemiBold, 17pt
    @nonobjc class var heading2: UIFont {
        return UIFont(name: FontName.wantedSansSemiBold.rawValue, size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    }
    
    // heading3: WantedSans-SemiBold, 22pt
    @nonobjc class var heading3: UIFont {
        return UIFont(name: FontName.wantedSansSemiBold.rawValue, size: 22) ?? UIFont.boldSystemFont(ofSize: 22)
    }
    
    // body1: WantedSans-Medium, 18pt
    @nonobjc class var body1: UIFont {
        return UIFont(name: FontName.wantedSansMedium.rawValue, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    // body2: WantedSans-Medium, 17pt
    @nonobjc class var body2: UIFont {
        return UIFont(name: FontName.wantedSansMedium.rawValue, size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    // body3: WantedSans-Medium, 16pt
    @nonobjc class var body3: UIFont {
        return UIFont(name: FontName.wantedSansMedium.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    // body4: WantedSans-Regular, 18pt
    @nonobjc class var body4: UIFont {
        return UIFont(name: FontName.wantedSansRegular.rawValue, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    // button1: WantedSans-SemiBold, 16pt
    @nonobjc class var button1: UIFont {
        return UIFont(name: FontName.wantedSansSemiBold.rawValue, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
    }
    
    // button2: WantedSans-Regular, 15pt
    @nonobjc class var button2: UIFont {
        return UIFont(name: FontName.wantedSansRegular.rawValue, size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    // button3: WantedSans-Regular, 14pt
    @nonobjc class var button3: UIFont {
        return UIFont(name: FontName.wantedSansRegular.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // caption1: WantedSans-Regular, 15pt
    @nonobjc class var caption1: UIFont {
        return UIFont(name: FontName.wantedSansRegular.rawValue, size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    // caption2: WantedSans-Medium, 13pt
    @nonobjc class var caption2: UIFont {
        return UIFont(name: FontName.wantedSansMedium.rawValue, size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    // tabbar1: WantedSans-Medium, 14pt
    @nonobjc class var tabbar1: UIFont {
        return UIFont(name: FontName.wantedSansMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}

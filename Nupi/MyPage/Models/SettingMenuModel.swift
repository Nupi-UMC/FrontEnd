//
//  SettingMenuModel.swift
//  Nupi
//
//  Created by 김건 on 2/15/25.
//

import Foundation
import UIKit

struct SettingMenuModel {
    let menuIcon: UIImage
    let menuLabel: String
}

extension SettingMenuModel {
    static func dummy() -> [SettingMenuModel] {
        return [
            SettingMenuModel(menuIcon: .settingIcon, menuLabel: "설정"),
            SettingMenuModel(menuIcon: .phoneIcon, menuLabel: "고객센터"),
            SettingMenuModel(menuIcon: .commentIcon, menuLabel: "누피 소식"),
            SettingMenuModel(menuIcon: .sendIcon, menuLabel: "의견 남기기"),
            SettingMenuModel(menuIcon: .bookIcon, menuLabel: "약관 및 정책"),
        ]
    }
}

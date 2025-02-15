//
//  MenuButtonModel.swift
//  Nupi
//
//  Created by 신연주 on 2/15/25.
//

import Foundation
import UIKit

struct MenuButtonModel {
    let menuIcon: UIImage
    let menuLabel: String
}

extension MenuButtonModel {
    static func dummy() -> [MenuButtonModel] {
        return [
            MenuButtonModel(menuIcon: .storePlaceIcon, menuLabel: "저장 장소"),
            MenuButtonModel(menuIcon: .storeRouteIcon, menuLabel: "저장 경로"),
        ]
    }
}

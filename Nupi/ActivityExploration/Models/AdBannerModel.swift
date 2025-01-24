//
//  BannerModel.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

struct AdBannerModel {
    let image: UIImage
}

extension AdBannerModel {
    static func dummny() -> [AdBannerModel] {
        return [
            AdBannerModel(image: .adBannerImage1),
            AdBannerModel(image: .adBannerImage2)
        ]
    }
}

//
//  BannerModel.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

struct BannerModel {
    let image: UIImage
}

extension BannerModel {
    static func dummny() -> [BannerModel] {
        return [
            BannerModel(image: .bannerImage1),
            BannerModel(image: .bannerImage2)
        ]
    }
}

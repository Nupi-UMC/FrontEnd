//
//  RouteDetailsModel.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

struct RouteDetailsModel {
    let image: UIImage
}

extension RouteDetailsModel {
    static func dummny() -> [RouteDetailsModel] {
        return [
            RouteDetailsModel(image: .bannerImage1),
            RouteDetailsModel(image: .adBannerImage2),
            RouteDetailsModel(image: .adBannerImage1),
            RouteDetailsModel(image: .adBannerImage2),
            RouteDetailsModel(image: .adBannerImage1),
        ]
    }
}

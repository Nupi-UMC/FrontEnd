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

struct RoutePlacesModel {
    let image: UIImage
    let title: String
}

extension RoutePlacesModel {
    static func dummny() -> [RoutePlacesModel] {
        return [
            RoutePlacesModel(image: .adBannerImage1, title: "도리무란도"),
            RoutePlacesModel(image: .adBannerImage1, title: "플래프"),
            RoutePlacesModel(image: .adBannerImage1, title: "팀버샵"),
            RoutePlacesModel(image: .adBannerImage1, title: "고스펑크"),
        ]
    }
}

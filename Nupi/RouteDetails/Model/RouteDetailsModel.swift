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

struct RouteReviewModel {
    let image: UIImage
    let nickname: String
    let content: String
}

extension RouteReviewModel {
    static func dummny() -> [RouteReviewModel] {
        return [
            RouteReviewModel(image: .adBannerImage1, nickname: "징징이", content: "꼭 가보세요 꼭 이 경로 따라가다가 만 보 걸었음 나만 당할 순 없다 근데 재미있긴 해요"),
            RouteReviewModel(image: .adBannerImage1, nickname: "와쟈뵷~!", content: "같이 간 친구가 무섭다고 울었어요 잼있뉸뎽 ㅠ.ㅠ")
        ]
    }
}

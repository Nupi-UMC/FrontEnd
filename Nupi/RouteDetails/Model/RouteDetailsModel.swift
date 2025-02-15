//
//  RouteDetailsModel.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

struct RouteDetailsResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteDetails
}

struct RouteDetails: Decodable {
    let routeId: Int
    let routeName: String
    let nickname: String
    let content: String
    let location: String
    let likeNum: Int
    let bookmarkNum: Int
    let isLiked: Bool
    let isBookmarked: Bool
    let storeList: [RouteStoresModel]
}

struct RouteStoresModel: Decodable {
    let storeId: Int
    let storeName: String
    let image: String?
    let latitude: Double
    let longitude: Double
}

struct RouteImageModel {
    let image: UIImage
}

extension RouteImageModel {
    static func dummny() -> [RouteImageModel] {
        return [
            RouteImageModel(image: .bannerImage1),
            RouteImageModel(image: .adBannerImage2),
            RouteImageModel(image: .adBannerImage1),
            RouteImageModel(image: .adBannerImage2),
            RouteImageModel(image: .adBannerImage1),
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
            RouteReviewModel(image: .adBannerImage1, nickname: "죽은징징이", content: "꼭 가보세요 꼭 이 경로 따라가다가 만 보 걸었음 나만 당할 순 없다 근데 재미있긴 해요"),
            RouteReviewModel(image: .adBannerImage1, nickname: "와쟈뵷~!", content: "같이 간 친구가 무섭다고 울었어요 잼있뉸뎽 ㅠ.ㅠ")
        ]
    }
}

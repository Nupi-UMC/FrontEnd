//
//  IncludedRoutesModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

struct IncludedRoutesModel {
    var image : UIImage
    var routeTitle : String
    var routeLocation : String
    var likeCountLabel : String
    var saveCountLabel : String
}

extension IncludedRoutesModel {
    static func dummy() -> [IncludedRoutesModel] {
        return [
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" )
        ]
    }
}

import Foundation


// MARK: - 장소 상세 조회 응답 모델
struct IncludedRoutesResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [Route]?
}

// MARK: - 장소 상세 정보 모델
struct Route: Decodable {
    let routeId: Int
    let routeName: String
    let location: String
    let likeNum: Int
    let bookmarkNum: Int
    let images : [String]?
    // 서버 JSON의 snake_case 키와 Swift의 camelCase 프로퍼티 매핑
        private enum CodingKeys: String, CodingKey {
            case routeId = "route_id"
            case routeName = "route_name"
            case location
            case likeNum = "like_num"
            case bookmarkNum = "bookmark_num"
            case images
        }
}

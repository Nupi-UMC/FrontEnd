//
//  PlaceDetailModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/30/25.
//

import Foundation


// MARK: - 장소 상세 조회 응답 모델
struct PlaceDetailResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PlaceDetailResult?
}

// MARK: - 장소 상세 정보 모델
struct PlaceDetailResult: Decodable {
    let id: Int
    let name: String
    let content: String
    let location: String
    let address: String
    let businessHours: String
    let number: String
    let snsUrl: String
    let slideImages: [String]?
    let category: String
    let groupInfo: String
    let likeNum: Int
    let bookmarkNum: Int
    let isLiked : Bool
    let isBookmarked : Bool
    let latitude : Float
    let longitude : Float
}

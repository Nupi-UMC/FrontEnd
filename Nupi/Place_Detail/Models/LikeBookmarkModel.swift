//
//  PlaceLikeModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/30/25.
//

import Foundation

// 장소 좋아요 API 응답 모델
struct PlaceLikeResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PlaceLikeResult?
}

// 좋아요 결과 모델
struct PlaceLikeResult: Decodable {
    let storeId: Int
    let saved: Bool  // true: 좋아요 설정, false: 좋아요 해제
}

// 장소 좋아요 API 응답 모델
struct PlaceBookmarkResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PlaceBookmarkResult?
}

// 좋아요 결과 모델
struct PlaceBookmarkResult: Decodable {
    let storeId: Int
    let saved: Bool  // true: 북마크 설정, false: 북마크 해제
}


// 경로 좋아요 API 응답 모델
struct RouteLikeResponse : Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteLikeResult?
}
struct RouteLikeResult : Decodable {
    let storeId : Int?
    let saved : Bool?
}

// 경로 북마크 API 응답 모델
struct RouteBookmarkResponse : Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteBookmarkResult?
}
struct RouteBookmarkResult : Decodable {
    let storeId : Int?
    let saved : Bool?
}

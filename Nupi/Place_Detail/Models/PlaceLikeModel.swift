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

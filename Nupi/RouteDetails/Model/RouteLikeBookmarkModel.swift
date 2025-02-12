//
//  RouteLikeBookmarkModel.swift
//  Nupi
//
//  Created by 선가연 on 2/12/25.
//

import Foundation

// 경로 좋아요 & 북마크 응답
struct RouteLikeBookmarkResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteLikeBookmarkResult
}

// 경로 좋아요 & 북마크 결과
struct RouteLikeBookmarkResult: Decodable {
    let routeId: Int
    let saved: Bool  // true: 설정됨, false: 해제됨
}

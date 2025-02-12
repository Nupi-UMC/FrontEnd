//
//  IncludedRoutesModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Foundation

// MARK: - 장소 상세 조회 응답 모델
struct IncludedRoutesResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteResult?
}

struct RouteResult : Decodable {
    let  routes : [Route]?
}

// MARK: - 장소 상세 정보 모델
struct Route: Decodable {
    let routeId: Int
    let routeName: String
    let location: String
    let likeNum: Int
    let bookmarkNum: Int
    let images : [String]?
}

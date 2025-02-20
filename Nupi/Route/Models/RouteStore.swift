//
//  StoreResponse.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//

import Foundation

struct RouteStoreResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RouteStoreResult
    let hasNext: Bool
    let cursor: Int
}

struct RouteStoreResult: Decodable {
    let storeList: [RouteStore]
}

struct RouteStore: Decodable {
    let id: Int
    let slideImages: [String]
    let name: String
    let category: String
    let groupInfo: String
    let location: String
    let likeNum: Int
    let bookmarkNum: Int
    let latitude: Double
    let longitude: Double
}

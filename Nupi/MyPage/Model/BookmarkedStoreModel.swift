//
//  BookmarkedStoreModel.swift
//  Nupi
//
//  Created by 선가연 on 2/15/25.
//

import Foundation

struct BookmarkedStoreResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: BookmarkedStoresResult
}

struct BookmarkedStoresResult: Decodable {
    let bookmarkedStores: [BookmarkedStoreModel]
}

struct BookmarkedStoreModel: Decodable {
    let storeId: Int
    let name: String
    let location: String
    let storePic: String?
}

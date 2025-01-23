//
//  StoreModel.swift
//  Nupi
//
//  Created by 선가연 on 1/22/25.
//

import UIKit

struct StoreModel {
    let storeId: Int
    let storeName: String
    let storePic: UIImage
    let storePlace: String
}

extension StoreModel {
    static func dummny() -> [StoreModel] {
        return [
            StoreModel(storeId: 1, storeName: "메리모어", storePic: .bannerImage1, storePlace: "성수역 1번 출구"),
            StoreModel(storeId: 2, storeName: "수비니어 앙뜨", storePic: .bannerImage1, storePlace: "성수역 1번 출구"),
            StoreModel(storeId: 3, storeName: "무드", storePic: .bannerImage1, storePlace: "성수역 1번 출구"),
            StoreModel(storeId: 4, storeName: "메리모어", storePic: .bannerImage1, storePlace: "성수역 1번 출구"),
        ]
    }
}

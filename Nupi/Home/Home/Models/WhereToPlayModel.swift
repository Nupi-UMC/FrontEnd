//
//  WhereToPlayModel.swift
//  Nupi
//
//  Created by 신연주 on 1/19/25.
//

import UIKit

struct WhereToPlayModel{
    let image: String
}

extension WhereToPlayModel{
    static func dummy() -> [WhereToPlayModel]{
        return [
            
         WhereToPlayModel(image: "around_me_image"),
         WhereToPlayModel(image: "hongdae_image"),
         WhereToPlayModel(image: "seongsu_image"),
         WhereToPlayModel(image: "euljiro_image"),
         WhereToPlayModel(image: "myeongdong_image")
         
        ]
    }
}

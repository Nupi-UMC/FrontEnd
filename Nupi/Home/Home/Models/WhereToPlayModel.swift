//
//  WhereToPlayModel.swift
//  Nupi
//
//  Created by 신연주 on 1/19/25.
//

import UIKit

struct WhereToPlayModel{
    let image: String
    let place: String
}

extension WhereToPlayModel{
    static func dummy() -> [WhereToPlayModel]{
        return [
            
         WhereToPlayModel(image: "around_me_image",place: "내 주변"),
         WhereToPlayModel(image: "hongdae_image",place: "홍대"),
         WhereToPlayModel(image: "seongsu_image",place: "성수"),
         WhereToPlayModel(image: "euljiro_image",place: "을지로"),
         WhereToPlayModel(image: "myeongdong_image",place: "명동")
         
        ]
    }
}

//
//  ButtonModel.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

struct ButtonModel{
    let category: String
}

extension ButtonModel{
    static func dummy() -> [ButtonModel]{
        return [
            
            ButtonModel(category: "전체"),
            ButtonModel(category: "소품샵"),
            ButtonModel(category: "굿즈샵"),
            ButtonModel(category: "맛집"),
            ButtonModel(category: "카페"),
            ButtonModel(category: "테마카페"),
            ButtonModel(category: "팝업"),
            ButtonModel(category: "전시"),
            ButtonModel(category: "클랙스"),
            
        ]
    }
}

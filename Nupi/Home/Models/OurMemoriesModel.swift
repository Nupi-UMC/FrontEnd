//
//  OurMemoriesModel.swift
//  Nupi
//
//  Created by 김건 on 1/16/25.
//

import UIKit

struct OurMemoriesModel{
    let image: UIImage
    let date: String
}

extension OurMemoriesModel{
    static func dummy() -> [OurMemoriesModel]{
        return[
            
            OurMemoriesModel(image: .ourMemoriesImage1, date: "23.10.07"),
            OurMemoriesModel(image: .ourMemoriesImage2, date: "24.01.04"),
            OurMemoriesModel(image: .ourMemoriesImage3, date: "24.05.29"),
            OurMemoriesModel(image: .ourMemoriesImage4, date: "24.09.11")
            
        ]
    }
}

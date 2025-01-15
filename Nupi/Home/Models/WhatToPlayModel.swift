//
//  WhatToPlayModel.swift
//  Nupi
//
//  Created by 김건 on 1/15/25.
//

import UIKit

struct WhatToPlayModel{
    let image: String
    let place: String
}

extension WhatToPlayModel{
    static func dummy() -> [WhatToPlayModel]{
        return [
            
            WhatToPlayModel(image: "izakaya_image", place: "Izakaya"),
            WhatToPlayModel(image: "lp_pop_image", place: "LP PUB"),
            WhatToPlayModel(image: "brunch_cafe_image", place: "Brunch Cafe"),
            WhatToPlayModel(image: "prop_shop_image", place: "Prop Shop"),
            WhatToPlayModel(image: "vintage_shop_image", place: "Vintage Shop ")
            
        ]
    }
}

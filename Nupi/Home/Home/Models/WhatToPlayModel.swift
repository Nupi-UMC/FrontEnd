//
//  WhatToPlayModel.swift
//  Nupi
//
//  Created by 김건 on 1/15/25.
//

import UIKit

struct WhatToPlayModel{
    let image: String
}

extension WhatToPlayModel{
    static func dummy() -> [WhatToPlayModel]{
        return [
            
            WhatToPlayModel(image: "izakaya_image"),
            WhatToPlayModel(image: "lp_pop_image"),
            WhatToPlayModel(image: "brunch_cafe_image"),
            WhatToPlayModel(image: "prop_shop_image"),
            WhatToPlayModel(image: "vintage_shop_image")
            
        ]
    }
}

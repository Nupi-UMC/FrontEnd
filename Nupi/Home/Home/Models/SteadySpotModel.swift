//
//  SteadySpotModel.swift
//  Nupi
//
//  Created by 김건 on 2/20/25.
//

import Foundation
import UIKit

struct SteadySpotModel{
    let image: UIImage
}

extension SteadySpotModel{
    static func dummy() -> [SteadySpotModel]{
        return[
            SteadySpotModel(image: .steadyPopularSpotImage1),
            SteadySpotModel(image: .steadyPopularSpotImage2)
        ]
    }
}
 

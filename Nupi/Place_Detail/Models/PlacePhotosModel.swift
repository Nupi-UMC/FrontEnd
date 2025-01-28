//
//  PlacePhotosModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

struct PlacePhotosModel {
    var image : UIImage
}

extension PlacePhotosModel {
    static func dummy() -> [PlacePhotosModel] {
        return [
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex),
            PlacePhotosModel(image: .ex)
        ]
    }
}

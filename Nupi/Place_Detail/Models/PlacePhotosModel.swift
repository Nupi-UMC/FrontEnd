//
//  PlacePhotosModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Foundation

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

struct PlacePhotoResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : PlacePhotoResult?
}

struct PlacePhotoResult : Decodable {
    let storeId : Int
    let tabImages : [String]?
}

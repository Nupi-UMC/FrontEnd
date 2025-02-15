//
//  PlacePhotosModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Foundation

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

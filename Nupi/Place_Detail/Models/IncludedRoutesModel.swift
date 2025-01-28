//
//  IncludedRoutesModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

struct IncludedRoutesModel {
    var image : UIImage
    var routeTitle : String
    var routeLocation : String
    var likeCountLabel : String
    var saveCountLabel : String
}

extension IncludedRoutesModel {
    static func dummy() -> [IncludedRoutesModel] {
        return [
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" ),
            IncludedRoutesModel(image: .ex, routeTitle: "귀여운 소품이 가득", routeLocation: "성수역 1번 출구", likeCountLabel: "389", saveCountLabel: "389" )
        ]
    }
}

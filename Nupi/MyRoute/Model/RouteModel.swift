//
//  RouteModel.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit

struct RouteModel {
    let routeId: Int
    let routeName: String
    let routePic: UIImage
    let routePlace: String
}

extension RouteModel {
    static func dummny() -> [RouteModel] {
        return [
            RouteModel(routeId: 1, routeName: "메리모어", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
            RouteModel(routeId: 2, routeName: "수비니어 앙뜨", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
            RouteModel(routeId: 3, routeName: "무드", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
            RouteModel(routeId: 4, routeName: "메리모어", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
        ]
    }
}

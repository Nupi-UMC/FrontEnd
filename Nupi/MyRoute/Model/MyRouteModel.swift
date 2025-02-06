//
//  RouteModel.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit

struct MyRouteResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MyRouteResult
}

struct MyRouteResult: Decodable {
    let routes: [MyRouteModel]
}

struct MyRouteModel: Decodable {
    let routeId: Int
    let routeName: String
    let routeLocation: String
    let routePic: String?
}

//extension MyRouteModel {
//    static func dummny() -> [MyRouteModel] {
//        return [
//            MyRouteModel(routeId: 1, routeName: "메리모어", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
//            MyRouteModel(routeId: 2, routeName: "수비니어 앙뜨", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
//            MyRouteModel(routeId: 3, routeName: "무드", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
//            MyRouteModel(routeId: 4, routeName: "메리모어", routePic: .bannerImage1, routePlace: "성수역 1번 출구"),
//        ]
//    }
//}

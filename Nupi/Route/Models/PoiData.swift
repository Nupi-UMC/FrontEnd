//
//  PoiData.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//

import Foundation
import CoreLocation

/// POI(장소) 데이터 모델
struct PoiData {
    var id: String
    var position: CLLocationCoordinate2D
    var styleID: String
    var name: String
}

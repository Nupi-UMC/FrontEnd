//
//  PoiManager.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//

import KakaoMapsSDK
import UIKit

class PoiManager {
    private var mapView: KakaoMap

    init(mapView: KakaoMap) {
        self.mapView = mapView
    }

    func createLabelLayer() {
        let manager = mapView.getLabelManager()
        
        let layerOption = LabelLayerOptions(
            layerID: "PoiLayer",
            competitionType: .none,
            competitionUnit: .symbolFirst,
            orderType: .rank,
            zOrder: 10
        )
        _ = manager.addLabelLayer(option: layerOption)
    }
    
    private func getIconForCategory(_ category: String) -> UIImage {
        let iconMapping: [String: UIImage] = [
            "맛집": UIImage.ricePoiIcon,
            "카페": UIImage.coffeePoiIcon,
            "팝업": UIImage.popupPoiIcon,
            "테마카페": UIImage.exhiPoiIcon,
            "소품샵": UIImage.sopoomPoiIcon,
            "클래스": UIImage.classPoiIcon,
            "보드카페": UIImage.boardPoiIcon,
        ]
        return iconMapping[category] ?? UIImage.ricePoiIcon
    }
    

    /// POI 스타일 생성
    func createPoiStyle(for category: String) -> String {
        let manager = mapView.getLabelManager()
        let icon = getIconForCategory(category)
        
   
        let iconStyle = PoiIconStyle(
            symbol: icon,
            anchorPoint: CGPoint(x: 0.0, y: 0.5)
        )
        
        
        let perLevelStyle = PerLevelPoiStyle(
            iconStyle: iconStyle,
            level: 0
        )
        

        let styleID = "customStyle_\(category)"
            let poiStyle = PoiStyle(
                styleID: styleID,
                styles: [perLevelStyle]
            )
            
            manager.addPoiStyle(poiStyle)
            return styleID
    }

    func createPois(with stores: [RouteStore]) {
        let manager = mapView.getLabelManager()
        guard let layer = manager.getLabelLayer(layerID: "PoiLayer") else { return }

        for store in stores {
            print("Adding POI - Name: \(store.name), Latitude: \(store.latitude), Longitude: \(store.longitude)")
            
            let styleID = createPoiStyle(for: store.category)
            
            let poiOption = PoiOptions(
                styleID: styleID,
                poiID: "\(store.id)"
            )
            poiOption.rank = 0

            let poi = layer.addPoi(option: poiOption, at: MapPoint(longitude: store.longitude, latitude: store.latitude))
            poi?.show()
        }
    }

}

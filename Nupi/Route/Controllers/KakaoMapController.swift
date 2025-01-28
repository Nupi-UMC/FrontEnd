//
//  KakaoMapController.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//

import KakaoMapsSDK

class KakaoMapController {
    private var controller: KMController?
    private var viewContainer: KMViewContainer?

    func attachView(_ view: KMViewContainer) {
        self.viewContainer = view
        controller = KMController(viewContainer: view)
        controller?.prepareEngine() // 지도 엔진 초기화
        print("✅ KakaoMapController: View attached and engine prepared")
    }

    func activateEngine() {
        controller?.prepareEngine() // 지도 엔진 활성화
        print("✅ KakaoMapController: Engine activated")
    }

    func resetEngine() {
        controller?.resetEngine() // 지도 엔진 초기화 상태
        print("✅ KakaoMapController: Engine reset")
    }
}

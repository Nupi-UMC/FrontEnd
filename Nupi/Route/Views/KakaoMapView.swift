//
//  KakaoMapView.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//
import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    private let mapController = KakaoMapController()

    func makeUIView(context: Context) -> KMViewContainer {
        let view = KMViewContainer()
        view.sizeToFit()
        mapController.attachView(view)
        return view
    }

    func updateUIView(_ uiView: KMViewContainer, context: Context) {
        if draw {
            mapController.activateEngine() // 엔진 활성화
        } else {
            mapController.resetEngine() // 엔진 초기화
        }
    }

    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: ()) {}
}

struct ContentView: View {
    @State var draw: Bool = false

    var body: some View {
        KakaoMapView(draw: $draw)
            .onAppear { self.draw = true }
            .onDisappear { self.draw = false }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

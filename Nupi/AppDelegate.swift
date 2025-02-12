//
//  AppDelegate.swift
//  Nupi
//
//  Created by Dana Lim on 1/4/25.
//

import UIKit
import KakaoMapsSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeKakaoMapsSDK()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        initializeKakaoMapsSDK()
    }
    
    /// Kakao Maps SDK 초기화 함수
       private func initializeKakaoMapsSDK() {
           if let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
               SDKInitializer.InitSDK(appKey: apiKey)
           } else {
               print("⚠️ Error: KAKAO_APP_KEY not found in Info.plist")
           }
       }


}

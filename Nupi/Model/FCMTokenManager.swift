//
//  FCMTokenManager.swift
//  Nupi
//
//  Created by Dana Lim on 2/5/25.
//

import Foundation
import Alamofire

// MARK : - 토큰 재발급
struct RefreshTokenRequest : Codable {
    let refresh_token : String
}

struct RefreshTokenResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : RefreshTokenResult?
}

struct RefreshTokenResult : Codable {
    let accessToken : String
    let refreshToken : String
    let expiresIn : Int
}


class FCMTokenManager {
    
    // 싱글톤 인스턴스 추가
        static let shared = FCMTokenManager()
        
        private init() {} // 외부에서 인스턴스 생성 방지
    /// Access Token 갱신
        func refreshAccessToken(completion: @escaping (String?) -> Void) {
            guard let refreshToken = KeychainService.load(for: "refreshToken") else {
                completion(nil)
                return
            }
            
            let url = "https://api-nupi.shop/api/auth/refresh"
            let parameters: [String: Any] = ["refreshToken": refreshToken]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: RefreshTokenResponse.self) { response in
                    switch response.result {
                    case .success(let tokenResponse):
                        let newAccessToken = tokenResponse.result?.accessToken
                        KeychainService.save(value: newAccessToken!, for: "accessToken")
                        completion(newAccessToken)
                    case .failure:
                        completion(nil)
                    }
                }
        }
}

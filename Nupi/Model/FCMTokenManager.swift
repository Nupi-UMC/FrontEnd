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
            print("저장된 Refresh Token 없음")
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
                    if let newAccessToken = tokenResponse.result?.accessToken,
                       let newRefreshToken = tokenResponse.result?.refreshToken {
                        
                        print("새 Access Token: \(newAccessToken)")
                        print("새 Refresh Token: \(newRefreshToken)")
                        
                        // 새로운 토큰을 Keychain에 저장
                        KeychainService.save(value: newAccessToken, for: "accessToken")
                        KeychainService.save(value: newRefreshToken, for: "refreshToken")
                        
                        completion(newAccessToken)
                    } else {
                        print("응답에서 Access Token 없음")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Refresh Token 요청 실패: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}

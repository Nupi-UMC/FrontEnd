//
//  AuthModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
// 로그인, 로그아웃, 토큰 재발급

import Foundation
import Alamofire

// MARK : - 로그인
struct LoginRequest : Codable {
    let email : String
    let password : String
}

struct LoginResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : LoginResult?
}

struct LoginResult : Decodable {
    let accessToken : String
    let refreshToken : String
    let expiresIn : Int
}


//MARK : - 로그아웃
struct LogoutResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    //let result : null
}

//MARK : - 사용자 정보 조회
struct UserInfoResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : UserInfoResult?
}

struct UserInfoResult : Decodable {
    let email : String
    let nickname : String
    let profile : String
}

class AuthService {
    static let shared = AuthService()
    
    /// 로그인 API 호출 및 토큰 저장
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = "https://api-nupi.shop/api/auth/login"
        let parameters = LoginRequest(email: email, password: password)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    if let tokenData = loginResponse.result {
                        // Access Token 및 Refresh Token 저장
                        KeychainService.save(value: tokenData.accessToken, for: "access_token")
                        KeychainService.save(value: tokenData.refreshToken, for: "refresh_token")
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure:
                    completion(false)
                }
            }
    }
}


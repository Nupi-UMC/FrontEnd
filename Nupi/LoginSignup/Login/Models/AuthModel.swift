//
//  AuthModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
// 로그인, 로그아웃, 토큰 재발급

import Foundation

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

struct LoginResult : Codable {
    let access_token : String
    let refresh_token : String
    let expires_in : Int
}


//MARK : - 로그아웃
struct LogoutResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    //let result : null
}

// MARK : - 토큰 재발급
struct RefreshTokenRequest : Codable {
    let refresh_token : String
}

struct RefreshTokenResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let result : RefreshTokenResult?
}

struct RefreshTokenResult : Codable {
    let access_token : String
    let refresh_token : String
    let expires_in : Int
}

//
//  SignupModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//회원가입 관련 요청과 응답을 처리

import Foundation

// MARK : - 회원가입
struct SignupRequest : Codable {
    let verification_id : Int
    let email : String
    let password : String
    let nickname : String
    let profile: String
}
struct SignupResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : Signupresult?
}
struct Signupresult : Codable {
    let user_id : Int
}

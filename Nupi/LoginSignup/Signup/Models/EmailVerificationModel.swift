//
//  EmailVerificationModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//이메일 인증 및 인증 코드 확인과 관련된 요청/응답을 처리

import Foundation

// MARK : - 이메일 인증 요청
struct EmailVerificationCodeRequest : Codable{
    let email : String
}
struct EmailVerificationCodeResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : EmailVerificationCodeResult?
}
struct EmailVerificationCodeResult : Codable {
    let expires_at : String
}

// MARK : - 인증 코드 확인
struct EmailVerificationCodeConfirmRequest : Codable{
    let email : String
    let verificationCode : String
}
struct EmailVerificationCodeConfirmResponse : Decodable {
    let isSuccess : Bool
    let code : String
    let message : String
    let result : EmailVerificationCodeConfirmResult?
}
struct EmailVerificationCodeConfirmResult : Decodable {
    let verification_id : Int?
}

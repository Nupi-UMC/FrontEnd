//
//  KeychainHelper.swift
//  Nupi
//
//  Created by 선가연 on 2/8/25.
//

import Security
import Foundation

class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    let service = "com.yourapp.nupi"

    // 액세스 토큰 저장 함수
    func saveToken(token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // 비밀번호 저장
            kSecAttrService as String: service,             // 서비스 이름
            kSecAttrAccount as String: "accessToken",       // 계정 이름
            kSecValueData as String: data                   // 토큰 데이터
        ]
        
        SecItemDelete(query as CFDictionary) // 기존 데이터 삭제
        SecItemAdd(query as CFDictionary, nil) // 새로운 데이터 저장
    }

    // 토큰 조회 함수
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: "accessToken",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }

    // 토큰 삭제 함수
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: "accessToken"
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

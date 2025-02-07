//
//  KeychainService.swift
//  Nupi
//
//  Created by Dana Lim on 2/5/25.
//

import Foundation
import Security

class KeychainService {
    
    static let shared = KeychainService()
    private init() {}
    
    // Keychain에 저장하는 함수
    class func save(value: String, for key: String) {

        let data = value.data(using: .utf8)!
        
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // 기존에 해당 key가 존재하는지 확인 후 삭제
        SecItemDelete(query as CFDictionary)
            
        // 새로운 데이터 저장
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // Keychain에서 데이터를 읽어오는 함수
    class func load(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne    // 중복되면 한개의 값만 가져옴
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        } else {
            return nil
        }
    }
    
    // Keychain에서 데이터 삭제
    class func delete(for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

/*
 토큰 저장 및 불러오는 키
     •    KeychainService.shared.save(value: accessToken, for: "access_token")
     •    KeychainService.shared.save(value: refreshToken, for: "refresh_token")
     •    KeychainService.shared.load(for: "access_token")
     •    KeychainService.shared.load(for: "refresh_token")
 */

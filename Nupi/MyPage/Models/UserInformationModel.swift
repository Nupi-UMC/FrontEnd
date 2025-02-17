//
//  UserInformationModel.swift
//  Nupi
//
//  Created by 김건 on 2/16/25.
//

import Foundation

struct UserInformationResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInformationModel
}

struct UserInformationModel: Decodable {
    let email: String
    let nickname: String
    let profile: String?
}
//
//  CalendarResult.swift
//  Nupi
//
//  Created by narong on 2/21/25.
//


struct CalendarResult: Decodable {
    let month: String
    let dates: [String]
}

struct CalendarResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CalendarResult?
}

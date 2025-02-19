//
//  HomeModel.swift
//  Nupi
//
//  Created by 신연주 on 2/20/25.
//

import Foundation

struct HomeResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: HomeResult
}

struct HomeResult: Decodable {
    let upcomming: UpcommingEvent?
    let groupList: [Group]
    let regions: [Region]
    let steadySpots: [SteadySpot]
}

// UpcommingEvent
struct UpcommingEvent: Decodable {
    let title: String
    let date: String
}

// 뭐하고 놀지?
struct Group: Decodable {
    let groupName: String
}

// 어디서 놀지?
struct Region: Decodable {
    let regionId: Int
    let regionName: String
}

// steadySpot
struct SteadySpot: Decodable {
    let name: String
    let place: String
    let location: String
    let description: String
}

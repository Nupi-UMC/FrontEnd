//
//  PlaceReviewsModel.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

struct PlaceReviewsModel {
    var profileImage : UIImage
    var nicknameLabel : String
    var reviewLabel : String
    var dateLabel : String
}

extension PlaceReviewsModel {
    static func dummy() -> [PlaceReviewsModel] {
        return [
            PlaceReviewsModel(profileImage: .ex, nicknameLabel: "wangwang", reviewLabel: "모루카 인형 엄청 큰 게 18000원이었어요 다른 곳은 막 4만원 하는데 여기는 대박 싸요 와~~ 글고 사장님이 엄청 친절하세요 피크민 인형들도 많고 못생기고 기염진 애들이 많아요 넘 조아요 또 가고 시퍼요", dateLabel: "2024.08.11"),
            PlaceReviewsModel(profileImage: .ex, nicknameLabel: "wangwang", reviewLabel: "모루카 인형 엄청 큰 게 18000원이었어요 다른 곳은 막 4만원 하는데 여기는 대박 싸요 와~~ 글고 사장님이 엄청 친절하세요 피크민 인형들도 많고 못생기고 기염진 애들이 많아요 넘 조아요 또 가고 시퍼요", dateLabel: "2024.08.11"),
            PlaceReviewsModel(profileImage: .ex, nicknameLabel: "wangwang", reviewLabel: "모루카 인형 엄청 큰 게 18000원이었어요 다른 곳은 막 4만원 하는데 여기는 대박 싸요 와~~ 글고 사장님이 엄청 친절하세요 피크민 인형들도 많고 못생기고 기염진 애들이 많아요 넘 조아요 또 가고 시퍼요", dateLabel: "2024.08.11"),
            PlaceReviewsModel(profileImage: .ex, nicknameLabel: "wangwang", reviewLabel: "모루카 인형 엄청 큰 게 18000원이었어요 다른 곳은 막 4만원 하는데 여기는 대박 싸요 와~~ 글고 사장님이 엄청 친절하세요 피크민 인형들도 많고 못생기고 기염진 애들이 많아요 넘 조아요 또 가고 시퍼요", dateLabel: "2024.08.11")
            
        ]
    }
}

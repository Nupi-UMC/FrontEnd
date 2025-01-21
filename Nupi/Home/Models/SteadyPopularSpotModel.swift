//
//  SteadyPopularSpotModel.swift
//  Nupi
//
//  Created by 신연주 on 1/11/25.
//

import UIKit

struct SteadyPopularSpotModel{
    let image: UIImage
    let name: String
    let address: String
    let station: String
    let description: String
}

extension SteadyPopularSpotModel{
    static func dummy() -> [SteadyPopularSpotModel] {
        return [
            
            SteadyPopularSpotModel(image: .steadyPopularSpotImage1, name:"Gentle Monster house,Dosan", address:"강남", station:"압구정로데오역 5번 출구", description:"해당 공간에는 젠틀몬스터와 더불어 감각적인 아름다움을 지향하는 코스메틱 브랜드 '탬버린즈'와 디저트를 통해 새로운 판타지를 구현하는 '누데이크'가 함께 입점했습니다."),
            SteadyPopularSpotModel(image: .steadyPopularSpotImage2, name:"RANDOM DIVERSITY", address:"노들", station:"노들역 2번 출구", description:"'랜덤 다이버시티'는 특정 기억이나 감정을 색이나 향, 소리 등 또 다른 감각으로 치환하는 참여형 미디어 아트 작품으로 큰 인기를 얻고 있으며, 매년 각기 다른 주제를 선택하여 새로운 전시를 선보입니다.")
            
        ]
    }
}

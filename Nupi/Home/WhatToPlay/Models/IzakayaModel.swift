//
//  IzakayaModel.swift
//  Nupi
//
//  Created by 신연주 on 1/24/25.
//

import UIKit

struct IzakayaModel{
    let image: UIImage
    let tag: String
    let place: String
    let station: String
    let description: String
}

extension IzakayaModel{
    static func dummy() -> [IzakayaModel]{
        return[
            
            IzakayaModel(image: .izakaya1, tag: "AD", place: "심 이자카야 강남", station: "강남역 10번 출구", description: "벚꽃을 옆에두고 한잔 할 수 있는 강남역 유일무이한 분위\n기 최고의 이자카야입니다. 다양한 사케와 하이볼을 수제\n안주들과 즐길 수 있습니다."),
            IzakayaModel(image: .izakaya2, tag: "New", place: "키즈나", station: "홍대입구역 7번 출구", description: "홍대의 아늑하고 조용한 일본식 선술집입니다. 20평 남짓\n한 좁고 아늑한 실내가 포근한 인상을 주는 곳입니다. \n4인 이하 소규모에 적합한 조용한 공간.")
            
        ]
    }
}

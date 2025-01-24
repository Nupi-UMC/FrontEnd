//
//  HongdaeModel.swift
//  Nupi
//
//  Created by 신연주 on 1/25/25.
//

import UIKit

struct HongdaeModel{
    let image: UIImage
    let tag: String
    let place: String
    let station: String
    let description: String
}

extension HongdaeModel{
    static func dummy() -> [HongdaeModel]{
        return[
            
            HongdaeModel(image: .hongdae1, tag: "Best", place: "943 킹스크로스 CAFE", station: "홍대입구역 9번 출구", description: "943 킹스크로스는 마법사를 테마로 꾸며진 이색적인 테마\n 플레이스입니다. 현재 지하 1층부터 4층까지 이용 가능하 \n며, 엘리베이터까지 완벽 준비 되어있습니다."),
            HongdaeModel(image: .hongdae2, tag: "New", place: "미래의 미래 (mirainomirai)", station: "홍대입구역 7번 출구", description: "독특한 공간과 취향의 아이템들.\n미래의 미래는 일본, 홍콩 감성의 인테리어 소품들과 Y2K\n에 걸맞는 패션 잡화들을 큐레이션 합니다.")
            
        ]
    }
}

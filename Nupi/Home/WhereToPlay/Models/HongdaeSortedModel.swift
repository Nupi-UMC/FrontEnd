//
//  HongdaeSortedModel.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

struct HongdaeSortedModel{
    let image: UIImage
    let place: String
    let station: String
}

extension HongdaeSortedModel{
    static func dummy() -> [HongdaeSortedModel]{
        return [
            
            HongdaeSortedModel(image: .hongdaeSortedImage1, place: "후카후카 스튜디오", station: "홍대입구역 1번 출구"),
            HongdaeSortedModel(image: .hongdaeSortedImage2, place: "오사카오야붕", station: "합정역 3번 출구"),
            HongdaeSortedModel(image: .hongdaeSortedImage3, place: "JASE", station: "합정역 1번 출구"),
            HongdaeSortedModel(image: .hongdaeSortedImage4, place: "지하미로", station: "홍대입구역 3번 출구")
            
        ]
    }
}





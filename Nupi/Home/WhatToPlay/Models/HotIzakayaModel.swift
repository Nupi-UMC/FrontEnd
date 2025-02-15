//
//  HotIzakayaModel.swift
//  Nupi
//
//  Created by 신연주 on 1/25/25.
//

import UIKit

struct HotIzakayaModel{
    let image: UIImage
    let place: String
    let station: String
}

extension HotIzakayaModel{
    static func dummy() -> [HotIzakayaModel]{
        return [
            
            HotIzakayaModel(image: .hotizakaya1, place: "무제서울", station: "홍대입구역 1번 출구"),
            HotIzakayaModel(image: .hotizakaya2, place: "오사카오야붕", station: "합정역 3번 출구"),
            HotIzakayaModel(image: .hotizakaya3, place: "밤말 홍대점", station: "홍대입구역 1번 출구"),
            HotIzakayaModel(image: .hotizakaya4, place: "지쿠조", station: "합정역 3번 출구"),
            HotIzakayaModel(image: .hotizakaya5, place: "갓포 히미츠", station: "압구정5번 출구"),
            HotIzakayaModel(image: .hotizakaya6, place: "파친코 을지로점", station: "을지로3가역 11번 출구")
        ]
    }
}


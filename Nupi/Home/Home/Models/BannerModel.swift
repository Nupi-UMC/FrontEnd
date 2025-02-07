//
//  BannerModel.swift
//  Nupi
//
//  Created by 김건 on 1/15/25.
//

import UIKit

struct BannerModel{
    let image: UIImage
    let title1: String
    let title2: String
}

extension BannerModel{
    static func dummy() -> [BannerModel]{
        return[
            
            BannerModel(image: .bannerImage1,title1:"누피 pick 부천 베이커리 Top 5",title2:"메리 크리스마스 누피!"),
            BannerModel(image: .bannerImage2,title1:"홍대에서 이자카야 뽕 뽑기",title2:"나에게는 여기가 오사카야"),
            BannerModel(image: .bannerImage3,title1:"망원과 연남 일대를 모두 모았어요",title2:"좋느 100% 소품샵"),
            BannerModel(image: .bannerImage4,title1:"커피 중독자 여기여기 붙어라",title2:"카페인이 필요해")
            
        ]
    }
}

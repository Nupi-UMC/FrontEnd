//
//  PlaceDetailView.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit

class PlaceDetailView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .line1
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerView = PlaceDetailHeaderView()
    
    private func addComponents(){
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(457)
        }
    }

}

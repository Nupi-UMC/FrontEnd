//
//  PlacePhotosCollectionViewCell.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlacePhotosCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlacePhotosCollectionViewCell"
    
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder){
        fatalError( "init(coder:) has not been implemented" )
    }
    
    /*private func addComponents(){
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }*/
}

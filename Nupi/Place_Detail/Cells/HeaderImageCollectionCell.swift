//
//  HeaderImageCollectionCell.swift
//  Nupi
//
//  Created by Dana Lim on 2/1/25.
//

import UIKit

class HeaderImageCollectionCell: UICollectionViewCell {
    static let identifier = "HeaderImageCollectionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: String) {
        imageView.loadImage(from: url)
    }
}

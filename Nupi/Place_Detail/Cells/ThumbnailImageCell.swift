//
//  ThumbnailImageCell.swift
//  Nupi
//
//  Created by Dana Lim on 2/8/25.
//

import UIKit

class ThumbnailImageCell: UICollectionViewCell {
    static let identifier = "ThumbnailImageCell"

    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8
        return imgView
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

    func configure(with imageUrl: String) {
        imageView.loadImage(from: imageUrl)
    }
}

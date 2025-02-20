//
//  CustomNearbyCell.swift
//  Nupi
//
//  Created by narong on 2/15/25.
//

import UIKit
import Then
import SDWebImage

class CustomNearbyCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CustomNearbyCell"
    
    // 이미지 슬라이드 컬렉션 뷰
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 173, height: 142) // 이미지 크기 설정
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    // 매장 이름
    let nameLabel = UILabel().then {
        $0.font = UIFont.heading2
        $0.textColor = .text1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 카테고리 이름
    let categoryLabel = UILabel().then {
        $0.font = UIFont.caption2
        $0.textColor = .icon1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 위치 아이콘
    private let locationIcon = UIImageView().then {
        $0.image = UIImage.roundPlace
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 위치 정보
    let locationLabel = UILabel().then {
        $0.font = UIFont.button3
        $0.textColor = .coffee
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setImage(UIImage.thumbsUpIcon, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 좋아요 개수
    let likeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 북마크 버튼
    let bookmarkButton = UIButton().then {
        $0.setImage(UIImage.bookmarkIcon, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 북마크 개수
    let bookmarkLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var images: [String] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(locationIcon)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(bookmarkLabel)
        
        NSLayoutConstraint.activate([
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 142),
            
            nameLabel.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 18),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            categoryLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            
            locationIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalToConstant: 16),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 5),
                        locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 104),
            likeButton.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5),
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            
            bookmarkButton.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 15),
            bookmarkButton.centerYAnchor.constraint(equalTo: likeLabel.centerYAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            
            bookmarkLabel.leadingAnchor.constraint(equalTo: bookmarkButton.trailingAnchor, constant: 5),
            bookmarkLabel.centerYAnchor.constraint(equalTo: bookmarkButton.centerYAnchor),
            
            bookmarkLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with store: RouteStore) {
        nameLabel.text = store.name
        categoryLabel.text = store.category
        locationLabel.text = store.location
        likeLabel.text = "\(store.likeNum)"
        bookmarkLabel.text = "\(store.bookmarkNum)"
        images = store.slideImages
        imageCollectionView.reloadData()
    }
    
    // MARK: - CollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: images[indexPath.item])
        return cell
    }
}

// MARK: - Custom ImageCollectionViewCell (URL Image 적용)
class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }
}

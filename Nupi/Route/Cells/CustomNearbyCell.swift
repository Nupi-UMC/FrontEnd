//
//  CustomNearbyCell.swift
//  Nupi
//
//  Created by narong on 2/15/25.
//

import UIKit

class CustomNearbyCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CustomNearbyCell"
    
    // 이미지 슬라이드 컬렉션 뷰
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // 매장 이름
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.heading2
        label.textColor = .text1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 카테고리 이름
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption2
        label.textColor = .icon1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 위치 아이콘
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.roundPlaceIcon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 위치 정보
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.button3
        label.textColor = .coffee
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 좋아요 버튼
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.thumbsUpIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 좋아요 개수
    let likeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 북마크 버튼
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tagIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 북마크 개수
    let bookmarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var images: [String] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
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
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        categoryLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
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
            
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 3),
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: images[indexPath.item])
        
        cell.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width - 20, height: 150)
    }
}

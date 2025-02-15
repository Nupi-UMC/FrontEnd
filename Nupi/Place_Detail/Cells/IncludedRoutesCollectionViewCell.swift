//
//  IncludedRoutesCollectionViewCell.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Alamofire

class IncludedRoutesCollectionViewCell: UICollectionViewCell {
    static let identifier = "IncludedRoutesCollectionViewCell"
    
    private var imageUrls: [String] = [] // API에서 받은 이미지 URL 저장
    private var routeId: Int? // API 호출 시 필요한 Route ID
    
    private let imagesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 130, height: 130)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    var routeTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .heading2
        label.textColor = .text1
        return label
    }()
    
    let locationImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "round_place"))
        return imageView
    }()
    
    var routeLocationLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .coffee
        return label
    }()
    
    var likeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_button"), for: .normal)
        return button
    }()
    
    var likeCountLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .icon2
        return label
    }()
    
    var saveButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save_button"), for: .normal)
        return button
    }()
    
    var saveCountLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .icon2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setupCollectionView()
        setupActions()
    }
    
    required init?(coder: NSCoder){
        fatalError( "init(coder:) has not been implemented" )
    }
    
    private func setupActions() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func addComponents(){
        self.addSubview(imagesCollectionView)
        self.addSubview(routeTitleLabel)
        self.addSubview(locationImageView)
        self.addSubview(routeLocationLabel)
        self.addSubview(likeButton)
        self.addSubview(likeCountLabel)
        self.addSubview(saveButton)
        self.addSubview(saveCountLabel)
        
        //  이미지 뷰의 레이아웃 설정 (크기와 위치)
        imagesCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(130) // 고정 높이
        }
        routeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(20)
        }
        routeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(routeTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(23)
            make.width.equalTo(157)
            make.height.equalTo(17)
        }
        locationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(routeTitleLabel.snp.leading)
            make.height.equalTo(15.58)
            make.width.equalTo(12.67)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(routeLocationLabel.snp.trailing).offset(60)
            make.width.equalTo(14.25)
            make.height.equalTo(14.67)
        }
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(likeButton.snp.trailing).offset(41)
            make.width.equalTo(12.67)
            make.height.equalTo(14.65)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
            make.height.equalTo(17)
            
        }
        saveCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(saveButton.snp.trailing).offset(3)
            make.height.equalTo(17)
        }
    }
    
    private func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ThumbnailImageCell.self, forCellWithReuseIdentifier: ThumbnailImageCell.identifier)
    }
    
    // API 호출
    func toggleLike(routeId: Int, completion: @escaping (Bool) -> Void) {
        let endpoint = "/api/routes/\(routeId)/like"
        
        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }
        
        APIClient.postRequestWithoutParameters(endpoint: endpoint, token: token) { (result: Result<RouteLikeResponse, AFError>) in
            switch result {
            case .success(let response):
                if let isLiked = response.result?.saved {
                    print("좋아요 변경 성공: \(isLiked)")
                    completion(isLiked)
                } else {
                    print("좋아요 응답 오류")
                    completion(false)
                }
            case .failure(let error):
                print("좋아요 변경 실패: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func toggleBookmark(routeId: Int, completion: @escaping (Bool) -> Void) {
        let endpoint = "/api/routes/\(routeId)/bookmark"
        
        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }
        
        APIClient.postRequestWithoutParameters(endpoint: endpoint, token: token) { (result: Result<RouteBookmarkResponse, AFError>) in
            switch result {
            case .success(let response):
                if let isSaved = response.result?.saved {
                    print("저장 변경 성공: \(isSaved)")
                    completion(isSaved)
                } else {
                    print("저장 응답 오류")
                    completion(false)
                }
            case .failure(let error):
                print("저장 변경 실패: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    @objc private func likeButtonTapped() {
        guard let routeId = routeId else { return }
        
        // 🔹 API 요청 실행
        toggleLike(routeId: routeId) { saved in
            DispatchQueue.main.async {
                // 🔹 API 응답을 기반으로 UI 업데이트
                let finalImage = saved ? "selectedLike" : "like_button"
                self.likeButton.setImage(UIImage(named: finalImage), for: .normal)
                
                // 🔹 API 응답을 기반으로 숫자 증감 반영
                let currentLikeCount = Int(self.likeCountLabel.text ?? "0") ?? 0
                let newLikeCount = saved ? currentLikeCount + 1 : max(currentLikeCount - 1, 0)
                self.likeCountLabel.text = "\(newLikeCount)"
            }
        }
    }

    @objc private func saveButtonTapped() {
        guard let routeId = routeId else { return }

        // 🔹 API 요청 실행
        toggleBookmark(routeId: routeId) { saved in
            DispatchQueue.main.async {
                // 🔹 API 응답을 기반으로 UI 업데이트
                let finalImage = saved ? "selectedBookmark" : "save_button"
                self.saveButton.setImage(UIImage(named: finalImage), for: .normal)
                
                // 🔹 API 응답을 기반으로 숫자 증감 반영
                let currentSaveCount = Int(self.saveCountLabel.text ?? "0") ?? 0
                let newSaveCount = saved ? currentSaveCount + 1 : max(currentSaveCount - 1, 0)
                self.saveCountLabel.text = "\(newSaveCount)"
            }
        }
    }
    
    private func toggleLikeButtonUI() {
        let currentImage = likeButton.image(for: .normal)
        let newImage = (currentImage == UIImage(named: "like_button")) ? UIImage(named: "selectedLike") : UIImage(named: "like_button")
        likeButton.setImage(newImage, for: .normal)
    }

    private func toggleBookmarkButtonUI() {
        let currentImage = saveButton.image(for: .normal)
        let newImage = (currentImage == UIImage(named: "save_button")) ? UIImage(named: "selectedBookmark") : UIImage(named: "save_button")
        saveButton.setImage(newImage, for: .normal)
    }
    
    // UI 업데이트
        func updateUI(with route: Route) {
            DispatchQueue.main.async {
                self.routeId = route.routeId
                self.routeTitleLabel.text = route.routeName
                self.routeLocationLabel.text = route.location
                self.likeCountLabel.text = "\(route.likeNum)"
                self.saveCountLabel.text = "\(route.bookmarkNum)"
                
                let likeImage = route.likeNum > 0 ? "selectedLike" : "like_button"
                self.likeButton.setImage(UIImage(named: likeImage), for: .normal)

                let saveImage = route.bookmarkNum > 0 ? "selectedBookmark" : "save_button"
                self.saveButton.setImage(UIImage(named: saveImage), for: .normal)

                self.imageUrls = route.images ?? []
                self.imagesCollectionView.reloadData()
            }
        }
}


extension IncludedRoutesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCell.identifier, for: indexPath) as? ThumbnailImageCell else {
            return UICollectionViewCell()
        }
        let imageUrl = imageUrls[indexPath.row]
        cell.configure(with: imageUrl)
        return cell
    }
    // 첫 번째 셀은 크기 다르게 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if imageUrls.count == 1 {
            return CGSize(width: 170, height: 130) // 한 개일 때 큰 사이즈 유지
        }
        return indexPath.item == 0 ? CGSize(width: 170, height: 130) : CGSize(width: 130, height: 130)
    }
}


//
//  PhotosViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Alamofire

class PlacePhotosViewController: UIViewController, UICollectionViewDataSource {
    
    private var imageURLs: [String] = [] // 사진 데이터 저장
    private var storeId : Int?
    
    // MARK: UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacePhotosCollectionViewCell.identifier, for: indexPath)
                as? PlacePhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageUrl = imageURLs[indexPath.row]
        cell.imageView.loadImage(from: imageUrl) // 확장 함수로 이미지 불러오기
                
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placePhotosView
        
        setupDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if let storeId = storeId {
                fetchPlacePhotos(storeId: storeId) // 🔹 View가 보일 때 자동으로 데이터 로드
            }
        }
    func setStoreId(_ id: Int) {
            self.storeId = id
        }
    
    private lazy var placePhotosView: PlacePhotosView = {
        let view = PlacePhotosView()
        return view
    }()
    
    private func setupDelegate(){
        placePhotosView.placePhotosCollectionView.dataSource = self
    }
    
    //서버에서 사진 리스트 가져오기
    private func fetchPlacePhotos(storeId: Int){
        let endpoint = "/api/stores/\(storeId)/images"

        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }
        
        APIClient.getRequest(endpoint: endpoint, token: token){ (result: Result<PlacePhotoResponse, AFError>) in
            switch result {
            case .success(let response):
                print("장소 사진 조회 성공: ", response)
                
                guard let photos = response.result?.tabImages else{
                    print("장소 사진 없음")
                    return
                }
                DispatchQueue.main.async {
                                    self.imageURLs = photos // 받아온 데이터를 저장
                                    self.placePhotosView.placePhotosCollectionView.reloadData() // UI 업데이트
                                }
            case .failure(let error) :
                print("장소 사진 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    /// 사진 데이터를 업데이트하는 메서드
        func updatePhotos(with urls: [String]) {
            self.imageURLs = urls // 데이터 저장
            DispatchQueue.main.async {
                self.placePhotosView.placePhotosCollectionView.reloadData() // UI 업데이트
            }
        }
    
}


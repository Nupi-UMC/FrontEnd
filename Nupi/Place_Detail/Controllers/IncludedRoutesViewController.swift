//
//  IncludedRoutesViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import Alamofire

class IncludedRoutesViewController: UIViewController, UICollectionViewDataSource {
    
    // `storeId`를 받을 프로퍼티
        /*var storeId: Int? {
            didSet {
                if let storeId = storeId {
                    fetchRoutesContainingPlace(storeId: storeId)
                }
            }
        }*/
    private var routes: [Route] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = includedRoutesView
        
        setupDelegate()
        
        fetchRoutesContainingPlace(storeId: 10)
        //storeId가 설정된 경우 자동으로 데이터 요청
        //if let storeId = storeId {fetchRoutesContainingPlace(storeId: storeId)}
    }
    
    private lazy var includedRoutesView: IncludedRoutesView = {
        let view = IncludedRoutesView()
        return view
    }()
    
    private func setupDelegate(){
        includedRoutesView.includedRoutesCollectionView.dataSource = self
    }
    
    // API 요청: 장소 포함 경로 조회
        private func fetchRoutesContainingPlace(storeId: Int) {
            let endpoint = "/api/stores/\(storeId)/detail?memberId=1"
            
            APIClient.getRequest(endpoint: endpoint, token: nil) { (result: Result<IncludedRoutesResponse, AFError>) in
                switch result {
                case .success(let response):
                    print("장소 포함 경로 목록 조회 성공:", response.result ?? [])
                    guard let routes = response.result else { return }
                    
                    DispatchQueue.main.async {
                        self.routes = routes // 데이터 저장
                        self.includedRoutesView.includedRoutesCollectionView.reloadData() // UI 업데이트
                    }
                    
                case .failure(let error):
                    print("장소 포함 경로 목록 조회 실패:", error.localizedDescription)
                }
            }
        }
    // UICollectionView DataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return routes.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncludedRoutesCollectionViewCell.identifier, for: indexPath) as? IncludedRoutesCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let route = routes[indexPath.row]
            cell.routeTitleLabel.text = route.routeName
            cell.routeLocationLabel.text = route.location
            cell.likeCountLabel.text = "\(route.likeNum)"
            cell.saveCountLabel.text = "\(route.bookmarkNum)"
            
            if let imageUrl = route.images?.first {
                cell.thumbnailImageView.loadImage(from: imageUrl)
            }
            
            return cell
        }
}

// UIImageView에 URL로 이미지 로드하는 확장 함수
extension UIImageView {
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

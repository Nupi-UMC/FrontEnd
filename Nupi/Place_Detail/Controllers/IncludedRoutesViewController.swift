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
    private var storeId:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = includedRoutesView
        
        setupDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if let storeId = storeId {
                fetchRoutesContainingPlace(storeId: storeId) // 🔹 View가 보일 때 자동으로 데이터 로드
            }
        }
    func setStoreId(_ id: Int) {
            self.storeId = id
        }
    
    private lazy var includedRoutesView: IncludedRoutesView = {
        let view = IncludedRoutesView()
        return view
    }()
    
    private func setupDelegate(){
        includedRoutesView.includedRoutesCollectionView.dataSource = self
    }
    
    // API 요청: 장소 포함 경로 조회
    func fetchRoutesContainingPlace(storeId: Int) {
        let endpoint = "/api/stores/\(storeId)/routes"
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJtZW1iZXJJZCI6MTAsImlhdCI6MTczODczMzE0OCwiZXhwIjoxNzM5OTQyNzQ4fQ.71bgaA4HTzhcNQN4TOV0PgYdJ0TDH983UF-wtErATPM"
            
            APIClient.getRequest(endpoint: endpoint, token: token) { (result: Result<IncludedRoutesResponse, AFError>) in
                switch result {
                case .success(let response):
                    print("장소 포함 경로 목록 조회 성공:", response.result ?? [])
                    guard let routes = response.result?.routes, !routes.isEmpty else { // `routes`가 nil 또는 빈 배열인지 확인
                                    print(" 장소 포함 경로 데이터가 없습니다.")
                                    return
                                }
                    
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
                cell.updateUI(with: route) // 셀의 UI 업데이트 메서드 호출
                
                return cell
        }
    // 뷰컨트롤러에서 데이터 업데이트를 처리
    func updateRoutes(with routes: [Route]) {
        self.routes = routes // 데이터 저장
        DispatchQueue.main.async {
            self.includedRoutesView.includedRoutesCollectionView.reloadData() // UI 업데이트
            }
        }
}

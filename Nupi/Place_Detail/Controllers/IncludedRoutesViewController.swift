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
                fetchRoutesContainingPlace(storeId: storeId) 
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
    
    //경로 호출해오기
    func fetchRoutesContainingPlace(storeId: Int) {
        let endpoint = "/api/stores/\(storeId)/routes"
        
        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }

        APIClient.getRequest(endpoint: endpoint, token: token) { (result: Result<IncludedRoutesResponse, AFError>) in
            switch result {
            case .success(let response):
                print("장소 포함 경로 목록 조회 성공:", response.result ?? [])

                guard let fetchedRoutes = response.result?.routes, !fetchedRoutes.isEmpty else {
                    print("장소 포함 경로 데이터가 없습니다.")
                    return
                }

                DispatchQueue.main.async {
                    self.routes = fetchedRoutes.sorted { $0.routeId < $1.routeId } //routeId 기준 정렬
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
        cell.updateUI(with: route) // UI 업데이트
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

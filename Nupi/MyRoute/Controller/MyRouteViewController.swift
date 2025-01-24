//
//  MyRouteViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit
import Kingfisher

class MyRouteViewController: UIViewController {
    
    private var myRoutes: [MyRouteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myRouteView
        setupDelegate()
        setupAction()
        setupNavigationBar()
        
        let defaultRoute = "created"
        fetchRoutes(myRoute: defaultRoute)
    }
    
    private lazy var myRouteView: MyRouteView = {
        let view = MyRouteView()
        return view
    }()
    
    // MARK: - function
    private func setupAction() {
        myRouteView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }
    
    private func setupDelegate() {
        myRouteView.routeCollectionView.dataSource = self
    }
    
    // 네비게이션 바 커스텀 함수
    private func setupNavigationBar() {
        // 뒤로가기 버튼 설정
        self.navigationController?.navigationBar.tintColor = .icon1
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // 타이틀 설정
        let titleLabel = UILabel().then {
            $0.text = "나의 경로"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
        
        // 오른쪽 메뉴 버튼 설정
        let menu = UIMenu(title: "", children: [
            UIAction(title: "편집", handler: { _ in
                // 편집 로직 추가 예정
            }),
            UIAction(title: "전체 삭제", handler: { _ in
                self.showDeleteAlert()
            })
        ])
        let menuButton = UIBarButtonItem(image: UIImage(named: "more_vertical_icon"), menu: menu)
        
        self.navigationItem.rightBarButtonItem = menuButton
    }
    
    // 삭제 팝업
    private func showDeleteAlert() {
        let alertVC = AlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        self.present(alertVC, animated: false, completion: nil)
    }
    
    private func fetchRoutes(myRoute: String) {
        let memberId = 1 // 추후 토큰으로 대체 예정
        
        APIClient.fetchMyRoutes(memberId: memberId, myRoute: myRoute) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self?.myRoutes = response.result.routes.map {
                        MyRouteModel(
                            routeId: $0.routeId,
                            routeName: $0.routeName,
                            routeLocation: $0.routeLocation,
                            routePic: $0.routePic)
                    }
                    DispatchQueue.main.async {
                        self?.myRouteView.routeCollectionView.reloadData()
                    }
                } else {
                    print("Error: \(response.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - action
    // 세그먼트 변경
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        let selectedIndex = segment.selectedSegmentIndex
        myRouteView.updateUnderlinePosition(selectedIndex: selectedIndex)
        
        let myRoute = selectedIndex == 0 ? "created" : "saved"
        fetchRoutes(myRoute: myRoute)
    }
}

extension MyRouteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRoutes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RouteCollectionViewCell.identifier,
            for: indexPath
        ) as? RouteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let route = myRoutes[indexPath.row]
        
        if let routePic = route.routePic, let url = URL(string: routePic) {
            cell.routeImageView.kf.setImage(with: url)
        } else {
            cell.routeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
        }

        cell.routeNameLabel.text = route.routeName
        cell.routeLocationLabel.text = route.routeLocation
        
        return cell
    }
}

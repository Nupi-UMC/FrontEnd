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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
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
        myRouteView.routeCollectionView.delegate = self
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
    
    // 나의 경로 API 호출
    private func fetchRoutes(myRoute: String) {        
        APIClient.fetchMyRoutes(
            myRoute: myRoute
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self.myRoutes = response.result.routes.map {
                        MyRouteModel(
                            routeId: $0.routeId,
                            routeName: $0.routeName,
                            routeLocation: $0.routeLocation,
                            routePic: $0.routePic)
                    }
                    DispatchQueue.main.async {
                        self.myRouteView.routeCollectionView.reloadData()
                        self.updateEmptyState(isEmpty: self.myRoutes.isEmpty)
                    }
                } else {
                    print("Error: \(response.message)")
                    DispatchQueue.main.async {
                        self.updateEmptyState(isEmpty: true)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.updateEmptyState(isEmpty: true)
                }
            }
        }
    }
    
    private func updateEmptyState(isEmpty: Bool) {
        myRouteView.emptyIconImageView.isHidden = !isEmpty
        myRouteView.emptyLabel.isHidden = !isEmpty
        myRouteView.routeCollectionView.isHidden = isEmpty
        
        let selectedIndex = myRouteView.segmentedControl.selectedSegmentIndex
        myRouteView.emptyLabel.text = selectedIndex == 0 ? "생성된 경로가 없습니다." : "저장된 경로가 없습니다."
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

extension MyRouteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRouteId = myRoutes[indexPath.row].routeId // 선택된 경로 정보
        let detailViewController = RouteDetailsViewController() // 경로 상세 페이지 VC
        
        // 선택된 경로 정보 전달
        detailViewController.routeId = selectedRouteId
        
        // 화면 전환
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

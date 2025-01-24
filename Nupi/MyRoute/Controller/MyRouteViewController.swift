//
//  MyRouteViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit

class MyRouteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myRouteView
        setupDelegate()
        setupAction()
        setupNavigationBar()
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
    
    // MARK: - action
    // 세그먼트 변경
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        myRouteView.updateUnderlinePosition(selectedIndex: segment.selectedSegmentIndex)
    }
}

extension MyRouteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RouteModel.dummny().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RouteCollectionViewCell.identifier,
            for: indexPath
        ) as? RouteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = RouteModel.dummny()
        cell.routeImageView.image = list[indexPath.row].routePic
        cell.routeNameLabel.text = list[indexPath.row].routeName
        cell.routePlaceLabel.text = list[indexPath.row].routePlace
        
        return cell
    }
}

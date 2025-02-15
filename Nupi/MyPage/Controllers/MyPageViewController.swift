//
//  MyPageViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class MyPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        setupActions()
        setupDelegates()
        setupNavigationBar()
    }
    
    private lazy var myPageView: MyPageView = {
        let view = MyPageView()
        return view
    }()
    
    // MARK: - function
    private func setupActions() {
    }
    
    private func setupDelegates() {
        myPageView.profileCollectionView.dataSource = self
    }
    
    // 네비게이션바 추가
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .naviBar
        self.navigationController?.navigationBar.tintColor = .icon1
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel().then {
            $0.text = "MY Page"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.hidesBackButton = true //네비게이션바 뒤로가기버튼 숨기기
    }
}
    

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myPageView.profileCollectionView{
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myPageView.profileCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.profileImageView.image = UIImage(named: "steady_popular_spot_image1") // 기본 프로필 이미지
            cell.nicknameLabel.text = "스눕도기독"
            cell.emailLabel.text = "arcticmon..."
            
            return cell
        }
        return UICollectionViewCell()
    }
}

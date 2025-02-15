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

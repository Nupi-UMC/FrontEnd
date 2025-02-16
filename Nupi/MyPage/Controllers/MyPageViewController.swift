//
//  MyPageViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class MyPageViewController: UIViewController {
    private var userInfo: UserInformationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        setupActions()
        setupDelegates()
        fetchUserInfo()
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
        myPageView.menuButtonCollectionView.dataSource = self
        //myPageView.menuButtonCollectionView.delegate = self
        myPageView.settingMenuCollectionView.dataSource = self
    }
    
    // 사용자 정보 API 호출
    private func fetchUserInfo() {
        APIClient.fetchUserInfo(
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self?.userInfo = UserInformationModel(
                        email: response.result.email,
                        nickname: response.result.nickname,
                        profile: response.result.profile
                    )
                    
                    DispatchQueue.main.async {
                        self?.myPageView
                            .profileCollectionView
                            .reloadData()
                    }
                } else {
                    print("API 실패: \(response.message)")
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
                if let responseCode = error.responseCode {
                    print("HTTP 상태 코드: \(responseCode)")
                }
            }
        }
    }
}
    

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myPageView.profileCollectionView{
            return userInfo == nil ? 0 : 1
        } else if collectionView == myPageView.menuButtonCollectionView{
            return MenuButtonModel.dummy().count
        } else if collectionView == myPageView.settingMenuCollectionView{
            return SettingMenuModel.dummy().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myPageView.profileCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let profileURL = userInfo?.profile, let url = URL(string: profileURL) {
                cell.profileImageView.kf.setImage(with: url)
            } else {
                cell.profileImageView.image = UIImage(named: "banner_image1")
            }
            cell.nicknameLabel.text = userInfo?.nickname ?? "로그인을 해주세요."
            cell.emailLabel.text = userInfo?.email ?? " "
            return cell
        } else if collectionView == myPageView.menuButtonCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuButtonCollectionViewCell.identifier, for: indexPath) as? MenuButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = MenuButtonModel.dummy()
            cell.menuIcon.image = list[indexPath.row].menuIcon
            cell.menuLabel.text = list[indexPath.row].menuLabel
            return cell
        } else if collectionView == myPageView.settingMenuCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsMenuCollectionViewCell.identifier, for: indexPath) as? SettingsMenuCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = SettingMenuModel.dummy()
            cell.menuIcon.image = list[indexPath.row].menuIcon
            cell.menuLabel.text = list[indexPath.row].menuLabel
            return cell
        }
        return UICollectionViewCell()
    }
}

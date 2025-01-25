//
//  ActivityExplorationViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

class ActivityExplorationViewController: UIViewController {
    
    private let categories = ["전체", "소품샵", "굿즈샵", "맛집", "카페", "테마카페", "팝업", "전시", "클래스"] // 카테고리 배열
    private var selectedCategory: Int = 0 // 선택된 카테고리
    private var selectedSort: String = "default" // 정렬 방식
    private var stores: [StoreModel] = [] // 장소 정보 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = activityExplorationView
        setupDelegate()
        setupActions()
        setupNavigationBar()
        fetchSearchStores()
        activityExplorationView.categoryCollectionView.reloadData()
    }
    
    private lazy var activityExplorationView: ActivityExplorationView = {
        let view = ActivityExplorationView()
        return view
    }()
    
    // MARK: - function
    private func setupDelegate() {
        activityExplorationView.adBannerCollectionView.dataSource = self
        activityExplorationView.categoryCollectionView.dataSource = self
        activityExplorationView.categoryCollectionView.delegate = self
        activityExplorationView.storeCollectionView.dataSource = self
    }
    
    private func setupActions() {
        showDropdownMenu()
    }
    
    // 네비게이션 바 커스텀 함수
    private func setupNavigationBar() {
        let titleLabel = UILabel().then {
            $0.text = "놀거리 탐색"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .icon1
    }
    
    // 놀거리 탐색 API 호출
    private func fetchSearchStores() {
        let memberId = 1 // 추후 토큰으로 대체 예정
        let latitude = 37.5142
        let longitude = 127.8983
        let category = self.selectedCategory
        let sort = self.selectedSort
        
        APIClient.fetchSearchStores(
            memberId: memberId,
            latitude: latitude,
            longitude: longitude,
            category: category,
            sort: sort
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self?.stores =
                    response.result.stores.map {
                        StoreModel(
                            storeId: $0.storeId,
                            storeName: $0.storeName,
                            storePic: $0.storePic,
                            storePlace: $0.storePlace,
                            saved: $0.saved)
                    }
                    DispatchQueue.main.async {
                        self?.activityExplorationView
                            .storeCollectionView
                            .reloadData()
                    }
                } else {
                    print("API 실패: \(response.message)")
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - action
    // 카테고리 버튼 클릭
    @objc private func categoryButtonDipTap(_ sender: UIButton) {
        guard let cell = sender.superview as? CategoryCollectionViewCell,
              let indexPath = activityExplorationView.categoryCollectionView.indexPath(for: cell) else {
            print("셀 또는 indexPath를 찾을 수 없습니다.")
            return
        }
        
        // 선택된 카테고리 업데이트
        selectedCategory = indexPath.row
        activityExplorationView.categoryCollectionView.reloadData()
        fetchSearchStores()
    }
    
    // 드롭다운 버튼 클릭
    @objc private func showDropdownMenu() {
        let options = ["기본", "북마크순", "추천순"]
        let menuItems = options.map { option in
            UIAction(title: option, handler: { _ in
                // 선택한 옵션 처리
                self.selectedSort = {
                    switch option {
                    case "기본": return "default"
                    case "북마크순": return "bookmark"
                    case "추천순": return "recommend"
                    default: return "default"
                    }
                }()
                self.activityExplorationView.dropdownButton.setTitle(option, for: .normal)
                self.fetchSearchStores()
            })
        }
        
        let menu = UIMenu(title: "", children: menuItems)
        
        // 버튼에 메뉴 연결
        self.activityExplorationView.dropdownButton.menu = menu
        self.activityExplorationView.dropdownButton.showsMenuAsPrimaryAction = true
    }
}

extension ActivityExplorationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == activityExplorationView.adBannerCollectionView {
            return AdBannerModel.dummny().count
        } else if collectionView == activityExplorationView.categoryCollectionView {
            return categories.count
        } else if collectionView == activityExplorationView.storeCollectionView {
            return stores.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == activityExplorationView.adBannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AdBannerCollectionViewCell.identifier,
                for: indexPath
            ) as? AdBannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let list = AdBannerModel.dummny()
            cell.bannerImageView.image = list[indexPath.row].image
            
            return cell
        } else if collectionView == activityExplorationView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let button = cell.categoryButton
            let isSelected = indexPath.row == selectedCategory
            
            button.setTitle(categories[indexPath.row], for: .normal)
            button.backgroundColor = isSelected ? .blue1 : .bg
            button.layer.borderColor = isSelected ? UIColor.blue4.cgColor : UIColor.blue1.cgColor
            button.setTitleColor(isSelected ? .blue3 : .blue4, for: .normal)
            button.addTarget(self, action: #selector(categoryButtonDipTap(_:)), for: .touchUpInside)
            
            return cell
        } else if collectionView == activityExplorationView.storeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoreCollectionViewCell.identifier,
                for: indexPath
            ) as? StoreCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let store = stores[indexPath.row]
            
            if let storePic = store.storePic, let url = URL(string: storePic) {
                cell.storeImageView.kf.setImage(with: url)
            } else {
                cell.storeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
            }
            
            cell.storeNameLabel.text = store.storeName
            cell.storeLocationLabel.text = store.storePlace
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// 카테고리 버튼 너비 유동적으로 설정
extension ActivityExplorationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let text = categories[indexPath.item]
        let tmpLabel = UILabel()
        tmpLabel.text = text
        tmpLabel.font = UIFont(name: "WantedSans-Medium", size: 16)
        tmpLabel.sizeToFit()
        
        let width = tmpLabel.intrinsicContentSize.width
        let height: CGFloat = 29
        
        return CGSize(width: width + 24, height: height)
    }
}

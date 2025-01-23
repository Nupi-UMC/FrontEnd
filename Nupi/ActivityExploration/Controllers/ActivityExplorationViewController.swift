//
//  ActivityExplorationViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

class ActivityExplorationViewController: UIViewController {
    
    // 카테고리 배열
    let categories = ["전체", "소품샵", "굿즈샵", "맛집", "카페", "테마카페", "팝업", "전시", "클래스"]
    private var selectedCategory: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = activityExplorationView
        setupDelegate()
        setupActions()
        activityExplorationView.categoryCollectionView.reloadData()
    }
    
    private lazy var activityExplorationView: ActivityExplorationView = {
        let view = ActivityExplorationView()
        view.backgroundColor = .bg
        return view
    }()
    
    private func setupDelegate() {
        activityExplorationView.adBannerCollectionView.dataSource = self
        activityExplorationView.adBannerCollectionView.delegate = self
        activityExplorationView.categoryCollectionView.dataSource = self
        activityExplorationView.categoryCollectionView.delegate = self
        activityExplorationView.storeCollectionView.dataSource = self
        activityExplorationView.storeCollectionView.delegate = self
    }
    
    private func setupActions() {
        activityExplorationView.dropdownButton.addTarget(self, action: #selector(showDropdownMenu), for: .touchUpInside)
    }
    
    @objc private func showDropdownMenu() {
        // 드롭다운 메뉴 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 드롭다운 항목 추가
        let options = ["기본", "옵션1", "옵션2", "옵션3"]
        for option in options {
            alert.addAction(UIAlertAction(title: option, style: .default, handler: { _ in
                // 선택한 옵션 처리
                self.activityExplorationView.dropdownButton.setTitle(option, for: .normal)
            }))
        }
        
        // 취소 버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // iPad 대응 (PopoverPresentation)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = activityExplorationView.dropdownButton
            popover.sourceRect = activityExplorationView.dropdownButton.bounds
        }
        
        // 드롭다운 메뉴 표시
        present(alert, animated: true, completion: nil)
    }

    
    // 카테고리 버튼 액션 함수
    @objc private func categoryButtonDipTap(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? CategoryCollectionViewCell,
              let indexPath = activityExplorationView.categoryCollectionView.indexPath(for: cell) else { return }
        
        // 선택된 카테고리 업데이트
        selectedCategory = indexPath.row
        activityExplorationView.categoryCollectionView.reloadData()
    }
}

extension ActivityExplorationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == activityExplorationView.adBannerCollectionView {
            return AdBannerModel.dummny().count
        } else if collectionView == activityExplorationView.categoryCollectionView {
            return categories.count
        } else if collectionView == activityExplorationView.storeCollectionView {
            return StoreModel.dummny().count
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
            
            let list = StoreModel.dummny()
            cell.storeImageView.image = list[indexPath.row].storePic
            cell.storeNameLabel.text = list[indexPath.row].storeName
            cell.storeLocationLabel.text = list[indexPath.row].storePlace
            
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

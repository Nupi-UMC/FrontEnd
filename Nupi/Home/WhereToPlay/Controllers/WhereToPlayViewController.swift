//
//  WhereToPlayViewController.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

class WhereToPlayViewController: UIViewController {
    private let categories = ["전체", "소품샵", "굿즈샵", "맛집", "카페", "테마카페", "팝업", "전시", "클래스"] // 카테고리 배열
    private var selectedCategory: Int = 0 // 선택된 카테고리
    private var selectedSort: String = "default" // 정렬 방식
    private var stores: [StoreModel] = [] // 장소 정보 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = whereToPlayView
        
        setupDataSource()
        setupActions()
        setupNavigationBar()
        fetchWhereToPlay()
        whereToPlayView.categoryButtonCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private lazy var whereToPlayView: WhereToPlayView = {
        let view = WhereToPlayView()
        return view
    }()
    
    // MARK: - function
    private func setupDataSource(){
        whereToPlayView.placeCollectionView.dataSource = self
        whereToPlayView.placeSortedCollectionView.dataSource = self
        whereToPlayView.categoryButtonCollectionView.dataSource = self
        whereToPlayView.categoryButtonCollectionView.delegate = self
    }
    
    private func setupActions() {
        whereToPlayView.dropdownButton.addTarget(self, action: #selector(showDropdownMenu), for: .touchUpInside)
      }
    
    // 어디서 놀지? API 호출
      private func fetchWhereToPlay() {
          //let memberId = 1 // 추후 토큰으로 대체 예정
          let regionId = 1
          let latitude = 37.5541
          let longitude = 127.4612
          let category = self.selectedCategory
          let sort = self.selectedSort

          APIClient.fetchWhereToPlay(
              //memberId: memberId,
              regionId: regionId,
              latitude: latitude,
              longitude: longitude,
              category: category,
              sort: sort
          ) { [weak self] result in
              switch result {
              case .success(let response):
                  if response.isSuccess {
                      self?.stores = response.result.stores.map {
                          StoreModel(
                              storeId: $0.storeId,
                              storeName: $0.storeName,
                              storePic: $0.storePic,
                              storePlace: $0.storePlace,
                              saved: $0.saved
                          )
                      }
                      
                      DispatchQueue.main.async {
                          self?.whereToPlayView
                              .placeSortedCollectionView
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
    
    // 네비게이션바 추가
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .icon1
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel().then {
            $0.text = "Hongdae"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
    }
    
    // MARK: - action
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
                self.whereToPlayView.dropdownButton.setTitle(option, for: .normal)
                self.fetchWhereToPlay()
            })
        }
        let menu = UIMenu(title: "", children: menuItems)
        
        // 버튼에 메뉴 연결
        self.whereToPlayView.dropdownButton.menu = menu
        self.whereToPlayView.dropdownButton.showsMenuAsPrimaryAction = true
    }

    
    
    // 카테고리 버튼 클릭
    @objc private func categoryButtonDipTap(_ sender: UIButton) {
        guard let cell = sender.superview as? CategoryButtonCollectionViewCell,
              let indexPath = whereToPlayView.categoryButtonCollectionView.indexPath(for: cell) else {
            print("셀 또는 indexPath를 찾을 수 없습니다.")
            return
        }
            
            //선택된 카테고리 업데이트
            selectedCategory = indexPath.row
            whereToPlayView.categoryButtonCollectionView.reloadData()
            fetchWhereToPlay()
    }
}

extension WhereToPlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == whereToPlayView.placeCollectionView{
            return HongdaeModel.dummy().count
        } else if collectionView == whereToPlayView.placeSortedCollectionView{
            return stores.count
        } else if collectionView == whereToPlayView.categoryButtonCollectionView{
            return categories.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == whereToPlayView.placeCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HongdaeCollectionViewCell.identifier, for: indexPath) as? HongdaeCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = HongdaeModel.dummy()
            cell.placeImageView.image = list[indexPath.row].image
            cell.tagLabel.text = list[indexPath.row].tag
            cell.placeLabel.text = list[indexPath.row].place
            cell.stationLabel.text = list[indexPath.row].station
            cell.descriptionLabel.text = list[indexPath.row].description
            return cell
        } else if collectionView == whereToPlayView.categoryButtonCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryButtonCollectionViewCell.identifier,
                for: indexPath
            ) as? CategoryButtonCollectionViewCell else {
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
        } else if collectionView == whereToPlayView.placeSortedCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HongdaeSortedCollectionViewCell.identifier, for: indexPath) as? HongdaeSortedCollectionViewCell else {
                return UICollectionViewCell()
            }
            let store = stores[indexPath.row]

            if let storePic = store.storePic, let url = URL(string: storePic) {
                cell.placeImageView.kf.setImage(with: url)
            } else {
                cell.placeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
            }
            cell.placeLabel.text = store.storeName
            cell.stationLabel.text = store.storePlace
            return cell
        }

        return UICollectionViewCell()
    }
}

// 카테고리 버튼 너비 유동적으로 설정
extension WhereToPlayViewController: UICollectionViewDelegateFlowLayout {
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


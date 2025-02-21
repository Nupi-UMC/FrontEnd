//
//  ViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    let bannerData = BannerModel.dummy()
    private var whatToPlayData: [Group] = []
    private var whereToPlayData: [Region] = []
    private var steadySpotDate: [SteadySpot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        setupActions()
        setupDataSource()
        fetchHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - function
    private func setupActions() {
        homeView.searchButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        homeView.myRouteButton.addTarget(self, action: #selector(myRouteButtonDidTap), for: .touchUpInside)
        homeView.scrollToTopButton.addTarget(self, action: #selector(scrollToTopButtonDidTap), for: .touchUpInside)
    }
    
    private func setupDataSource(){
        homeView.scrollView.delegate = self
        homeView.bannerCollectionView.dataSource = self
        //rootView.bannerCollectionView.delegate = self
        homeView.whatToPlayCollectionView.dataSource = self
        //rootView.whatToPlayCollectionView.delegate = self
        homeView.whereToPlayCollectionView.dataSource = self
        homeView.ourMemoriesCollectionView.dataSource = self
        homeView.steadySpotCollectionView.dataSource = self
    }
        
    // 홈화면 API 호출
    private func fetchHome() {
        APIClient.fetchHome(
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    //let upcomingEvent = response.result.upcomming
                    self?.whatToPlayData = response.result.groupList.prefix(5).map{
                        Group(
                            groupName: $0.groupName
                        )
                    }
                    self?.whereToPlayData = response.result.regions.map{
                        Region(
                            regionId: $0.regionId,
                            regionName: $0.regionName
                        )
                    }
                    self?.steadySpotDate = response.result.steadySpots.map{
                        SteadySpot(
                            name: $0.name,
                            place: $0.place,
                            location: $0.location,
                            description: $0.description
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self?.homeView
                            .whatToPlayCollectionView
                            .reloadData()
                        self?.homeView
                            .whereToPlayCollectionView
                            .reloadData()
                        self?.homeView
                            .steadySpotCollectionView
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

    // MARK: - action
    @objc
    private func searchButtonDidTap() {
        let activityExplorationVC = ActivityExplorationViewController()
        self.navigationController?.pushViewController(activityExplorationVC, animated: true)
    }
    
    @objc
    private func myRouteButtonDidTap() {
        let myRouteVC = MyRouteViewController()
        self.navigationController?.pushViewController(myRouteVC, animated: true)
    }
    
    @objc
    private func whatToPlayButtonDidTap(_ sender: UIButton) {
        let groupIndex = sender.tag
        let selectedGroup = whatToPlayData[groupIndex]
        
        let whatToPlayVC = WhatToPlayViewController(groupName: selectedGroup.groupName)
        self.navigationController?.pushViewController(whatToPlayVC, animated: true)
    }
    
    @objc
    private func whereToPlayButtonDidTap(_ sender: UIButton) {
        let regionIndex = sender.tag
        let selectedRegion = whereToPlayData[regionIndex]
        
        let whereToPlayVC = WhereToPlayViewController(regionId: selectedRegion.regionId, regionName: selectedRegion.regionName)
        self.navigationController?.pushViewController(whereToPlayVC, animated: true)
    }
    
    
    @objc private func scrollToTopButtonDidTap() {
        let scrollView = homeView.scrollView
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.bannerCollectionView {
            return BannerModel.dummy().count
        } else if collectionView == homeView.whatToPlayCollectionView {
            return whatToPlayData.count
        } else if collectionView == homeView.whereToPlayCollectionView {
            return whereToPlayData.count
        } else if collectionView == homeView.ourMemoriesCollectionView {
            return OurMemoriesModel.dummy().count
        } else if collectionView == homeView.steadySpotCollectionView {
            return steadySpotDate.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = BannerModel.dummy()
            cell.imageView.image = list[indexPath.row].image
            cell.titleLabel1.text = list[indexPath.row].title1
            cell.titleLabel2.text = list[indexPath.row].title2
            return cell
        } else if collectionView == homeView.whatToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhatToPlayCollectionViewCell.identifier, for: indexPath) as? WhatToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhatToPlayModel.dummy()
            let group = whatToPlayData[indexPath.row]
            
            cell.whatToPlayButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.whatToPlayLabel.text = group.groupName
            
            // 버튼에 indexPath.row를 태그로 추가하여 구분 가능하도록 설정
            cell.whatToPlayButton.tag = indexPath.row
            cell.whatToPlayButton.addTarget(self, action: #selector(whatToPlayButtonDidTap(_:)), for: .touchUpInside)
                    
            return cell
        } else if collectionView == homeView.whereToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhereToPlayCollectionViewCell.identifier, for: indexPath) as? WhereToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhereToPlayModel.dummy()
            let region = whereToPlayData[indexPath.row]
            
            cell.whereToPlayButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.whereToPlayLabel.text = region.regionName
            
            // 버튼에 indexPath.row를 태그로 추가하여 구분 가능하도록 설정
            cell.whereToPlayButton.tag = indexPath.row
            cell.whereToPlayButton.addTarget(self, action: #selector(whereToPlayButtonDidTap(_:)), for: .touchUpInside)
            
            
            return cell
        } else if collectionView == homeView.ourMemoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OurMemoriesCollectionViewCell.identifier, for: indexPath) as?
                    OurMemoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = OurMemoriesModel.dummy()
            cell.memoriesimageView.image = list[indexPath.row].image
            cell.dateLabel.text = list[indexPath.row].date
            return cell
        } else if collectionView == homeView.steadySpotCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SteadySpotsCollectionViewCell.identifier, for: indexPath) as?
                    SteadySpotsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = SteadySpotModel.dummy()
            let steadySpot = steadySpotDate[indexPath.row]
            cell.placeImageView.image = list[indexPath.row].image
            
            cell.placeName.text = steadySpot.name
            cell.placeAddress.text = steadySpot.place
            cell.placeStation.text = steadySpot.location
            cell.placeDescription.text = steadySpot.description
            return cell
        }
            
        return UICollectionViewCell()
    }
}


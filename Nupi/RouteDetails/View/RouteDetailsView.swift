//
//  RouteDetailsView.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteDetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    // 컨텐트 뷰
    private let contentView = UIView()

    // 경로 이미지 컬렉션 뷰
    let routeImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        let itemWidth: CGFloat = UIScreen.main.bounds.width
        $0.itemSize = CGSize(width: itemWidth, height: 335)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.sectionInset = .zero
    }).then {
        $0.backgroundColor = .clear
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(RouteImageCollectionViewCell.self, forCellWithReuseIdentifier: RouteImageCollectionViewCell.identifier)
    }
    
    // 경로 타이틀 레이블
    let routeTitleLabel = UILabel().then {
        $0.text = "Hardcore!!!"
        $0.font = .heading3
        $0.textColor = .blue3
    }
    
    // 경로 위치 아이콘
    private let routeLocationIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .roundPlaceIcon
    }
    
    // 경로 위치 레이블
    let routeLocationLabel = UILabel().then {
        $0.text = "홍대입구역 1번 출구"
        $0.textColor = .coffee
        $0.font = .button2
    }
    
    // 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setTitle("389", for: .normal)
        $0.setTitleColor(.icon2, for: .normal)
        $0.titleLabel?.font = .button3
        $0.setImage(.likeIcon, for: .normal)
    }
    
    // 북마크 버튼
    let bookmarkButton = UIButton().then {
        $0.setTitle("389", for: .normal)
        $0.setTitleColor(.icon2, for: .normal)
        $0.titleLabel?.font = .button3
        $0.setImage(.bookmarkIcon, for: .normal)
    }
    
    // 구분선
    private let divider = UIView().then {
        $0.backgroundColor = .line1
    }
    
    // 경로 소개 타이틀 레이블
    private lazy var routeDescriptionTitleLabel = UILabel().then {
        $0.text = "경로 소개"
        $0.font = .body2
        $0.textColor = .black
    }
    
    // 경로 소개 내용 레이블
    let routeDescriptionContentLabel = UILabel().then {
        $0.text = "이상한 거 좋아하는 사람들을 위해 만들었어요 정말 이상한 거밖에 없어요 하드코어!!!! 🤘"
        $0.font = .body3
        $0.textColor = .icon2
        $0.numberOfLines = 5
    }
    
    // 경로 제작자 레이블
    let routeCreatorLabel = UILabel().then {
        $0.text = "제작자: snoopdog"
        $0.font = .caption2
        $0.textColor = .icon2
    }
    
    private lazy var followRouteButton = createTitleButton(title: "이 경로 따라가기")
    
    // 제목 버튼 생성 함수
    private func createTitleButton(title: String) -> UIButton {
        let button = UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .body2
            $0.setImage(.rightIcon, for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        }
    
        return button
    }
    
    private func setViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // contentView 내부에 추가
        [
            routeImageCollectionView,
            routeTitleLabel,
            routeLocationIcon,
            routeLocationLabel,
            likeButton,
            bookmarkButton,
            divider,
            routeDescriptionTitleLabel,
            routeDescriptionContentLabel,
            routeCreatorLabel,
            followRouteButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
        
        routeImageCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(335)
        }
        
        routeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(routeImageCollectionView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(27)
        }
        
        routeLocationIcon.snp.makeConstraints {
            $0.top.equalTo(routeTitleLabel.snp.bottom).offset(14.5)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(19)
        }
        
        routeLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(routeLocationIcon)
            $0.leading.equalTo(routeLocationIcon.snp.trailing).offset(3)
            $0.trailing.equalTo(routeTitleLabel.snp.trailing)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(routeLocationIcon.snp.bottom).offset(8)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(likeButton.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(12)
            $0.height.equalTo(11)
            $0.horizontalEdges.equalToSuperview()
        }
        
        routeDescriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        routeDescriptionContentLabel.snp.makeConstraints {
            $0.top.equalTo(routeDescriptionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(routeDescriptionTitleLabel)
        }
        
        routeCreatorLabel.snp.makeConstraints {
            $0.top.equalTo(routeDescriptionContentLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        followRouteButton.snp.makeConstraints {
            $0.top.equalTo(routeCreatorLabel.snp.bottom).offset(44)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
}

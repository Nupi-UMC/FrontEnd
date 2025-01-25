//
//  PlaceDetailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    private lazy var placeDetailView: PlaceDetailView = {
        let view = PlaceDetailView()
        return view
    }()
    
    // Child View Controllers
    private let detailVC = PlaceDetailInfoViewController()
    private let photosVC = PlacePhotosViewController()
    private let routesVC = IncludedRoutesViewController()
    private let reviewsVC = PlaceReviewsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = placeDetailView

        placeDetailView.headerView.setUpImageSlider()
        
        setupSegmentedControl()
        showChildViewController(detailVC) // 초기 화면 설정
    }
    
    private func setupSegmentedControl() {
        let segmentedControl = placeDetailView.getSegmentedControl()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Remove current child view controller
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        // Add selected child view controller
        switch sender.selectedSegmentIndex {
        case 0:
            showChildViewController(detailVC)
        case 1:
            showChildViewController(photosVC)
        case 2:
            showChildViewController(routesVC)
        case 3:
            showChildViewController(reviewsVC)
        default:
            break
        }
        updateSegmentedControlLinePosition(sender)
    }
    
    private func updateSegmentedControlLinePosition(_ segmentedControl: UISegmentedControl) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = CGFloat(segmentedControl.selectedSegmentIndex) * segmentWidth + 16
        
        UIView.animate(withDuration: 0.3) {
            self.placeDetailView.segmentedControlLineView.snp.updateConstraints { make in
                make.leading.equalTo(segmentedControl.snp.leading).offset(leadingDistance)
            }
            self.placeDetailView.layoutIfNeeded()
        }
    }
    
    private func showChildViewController(_ childVC: UIViewController) {
        addChild(childVC)
        placeDetailView.containerView.addSubview(childVC.view)
        childVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        childVC.didMove(toParent: self)
    }
}

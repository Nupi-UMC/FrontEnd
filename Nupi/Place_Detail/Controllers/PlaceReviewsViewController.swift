//
//  ReviewsViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceReviewsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placeReviewsView
    }
    
    private lazy var placeReviewsView: PlaceReviewsView = {
        let view = PlaceReviewsView()
        return view
    }()

}

//
//  ReviewsViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class ReviewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = reviewsView
    }
    
    private lazy var reviewsView: ReviewsView = {
        let view = ReviewsView()
        return view
    }()

}

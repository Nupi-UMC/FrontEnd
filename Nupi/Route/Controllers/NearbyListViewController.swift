//
//  NearbyListViewController.swift
//  Nupi
//
//  Created by narong on 2/12/25.
//
import UIKit

class NearbyListViewController: UIViewController {

    private let handleIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue1
        view.layer.cornerRadius = 3
        return view
    }()

    private let tableView = UITableView()
    var routeStore: [RouteStore] = []

    private var initialHeight: CGFloat = 120
    private var expandedHeight: CGFloat {
        return UIScreen.main.bounds.height - 50
    }
    private var currentHeight: CGFloat = 120

    private var panGestureRecognizer: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPanGesture()
        setupTapGesture()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.bg
        view.layer.cornerRadius = 16
        view.clipsToBounds = true

        view.addSubview(handleIndicator)
        handleIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handleIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            handleIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            handleIndicator.widthAnchor.constraint(equalToConstant: 50),
            handleIndicator.heightAnchor.constraint(equalToConstant: 6)
        ])

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CustomNearbyCell.self, forCellReuseIdentifier: "CustomNearbyCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: handleIndicator.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupPanGesture() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        if let panGestureRecognizer = panGestureRecognizer {
            view.addGestureRecognizer(panGestureRecognizer)
        }
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        handleIndicator.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapGesture() {
        animateViewHeight(to: expandedHeight)
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view.superview).y

        switch gesture.state {
        case .changed:
            let newHeight = currentHeight - translation
            if newHeight >= initialHeight && newHeight <= expandedHeight {
                view.frame.origin.y = UIScreen.main.bounds.height - newHeight
            }
        case .ended:
            let velocity = gesture.velocity(in: view).y
            let newHeight = currentHeight - translation

            if newHeight >= (expandedHeight - 100) || velocity < -500 {
                // 위로 확장
                animateViewHeight(to: expandedHeight)
            } else if newHeight <= (initialHeight + 100) || velocity > 500 {
                // 아래로 축소
                animateViewHeight(to: initialHeight)
            } else {
                // 제자리로
                animateViewHeight(to: currentHeight)
            }
        default:
            break
        }
    }

    private func animateViewHeight(to height: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y = UIScreen.main.bounds.height - height
        }) { _ in
            self.currentHeight = height
        }
    }
}

extension NearbyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeStore.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNearbyCell", for: indexPath) as? CustomNearbyCell else {
            return UITableViewCell()
        }

        let store = routeStore[indexPath.row]
        cell.configure(with: store)

        return cell
    }

}

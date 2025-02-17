//
//  RouteOverlayView.swift
//  Nupi
//
//  Created by narong on 1/28/25.
//
import UIKit

class RouteOverlayView: UIView {
    private let bottomModal = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        // ✅ 검색 바
        let searchBar = createSearchBar()
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 46)
        ])

        
        // ✅ '이 지역 전체 보기' 버튼
        let showAreaButton = createShowAreaButton()
        addSubview(showAreaButton)
        NSLayoutConstraint.activate([
            showAreaButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            showAreaButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showAreaButton.widthAnchor.constraint(equalToConstant: 173),
            showAreaButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // ✅ 추가 버튼
        let addButton = createAddButton()
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 51),
            addButton.heightAnchor.constraint(equalToConstant: 51)
        ])
        
    }
    
    // 🔹 검색 바
    private func createSearchBar() -> UITextField {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.992, alpha: 1)
        searchBar.layer.cornerRadius = 23
        searchBar.layer.borderWidth = 2
        searchBar.layer.borderColor = UIColor.blue1.cgColor
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.1
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchBar.layer.shadowRadius = 10
        
        let iconImageView = UIImageView(image: UIImage.searchIcon)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        searchBar.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = "가고 싶은 장소, 테마를 검색해 보세요!"
        label.textColor = .gray
        label.font = .body3
        label.translatesAutoresizingMaskIntoConstraints = false
        searchBar.addSubview(label)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -16)
        ])
        
        return searchBar
    }
    
    // 🔹 '이 지역 전체 보기'
    private func createShowAreaButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.icon1
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.25
        button.layer.borderColor = UIColor.bg.cgColor
        
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage.arrowMoveIcon)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.widthAnchor.constraint(equalToConstant: 19).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let label = UILabel()
        label.text = "이 지역 전체 보기"
        label.textColor = UIColor(red: 0.871, green: 0.902, blue: 0.937, alpha: 1)
        label.font = .body3
        label.textAlignment = .center
        
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(label)
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -12)
        ])
        
        return button
    }
    
    // 🔹 경로 생성 버튼
    private func createAddButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let plusIcon = UIImage.addIcon
        button.setImage(plusIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.imageView!.widthAnchor.constraint(equalToConstant: 32),
            button.imageView!.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        button.backgroundColor = UIColor.icon1
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.25
        button.layer.borderColor = UIColor.bg.cgColor
        
        button.addTarget(self, action: #selector(navigateToRouteCreation), for: .touchUpInside)
        return button
    }
    
    @objc private func navigateToRouteCreation() {
        if let parentVC = self.parentViewController {
            // let routeCreationVC = RouteCreationViewController()
            // parentVC.present(routeCreationVC, animated: true, completion: nil)
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}

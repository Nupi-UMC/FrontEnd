//
//  CreateRouteView.swift
//  Nupi
//
//  Created by narong on 2/20/25.
//


// CreateRouteView.swift
import UIKit

class CreateRouteView: UIView {
    
    // UI 요소들
    let routeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "경로의 이름을 입력해주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let routeNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "예) 경로 1"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "장소를 추가해주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addPlaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("장소 추가", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "언제 가는 일정인가요?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .inline
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    let createRouteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("경로 자동 생성", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // UI 배치
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(routeNameLabel)
        addSubview(routeNameTextField)
        addSubview(placeLabel)
        addSubview(addPlaceButton)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(createRouteButton)
        
        NSLayoutConstraint.activate([
            // routeNameLabel
            routeNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            routeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            routeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // routeNameTextField
            routeNameTextField.topAnchor.constraint(equalTo: routeNameLabel.bottomAnchor, constant: 8),
            routeNameTextField.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            routeNameTextField.trailingAnchor.constraint(equalTo: routeNameLabel.trailingAnchor),
            routeNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // placeLabel
            placeLabel.topAnchor.constraint(equalTo: routeNameTextField.bottomAnchor, constant: 20),
            placeLabel.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: routeNameLabel.trailingAnchor),
            
            // addPlaceButton
            addPlaceButton.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 8),
            addPlaceButton.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            
            // dateLabel
            dateLabel.topAnchor.constraint(equalTo: addPlaceButton.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: routeNameLabel.trailingAnchor),
            
            // datePicker
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            
            // createRouteButton
            createRouteButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
            createRouteButton.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            createRouteButton.trailingAnchor.constraint(equalTo: routeNameLabel.trailingAnchor),
            createRouteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

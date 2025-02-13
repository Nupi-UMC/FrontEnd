//
//  ScheduleCell.swift
//  Nupi
//
//  Created by Dana Lim on 2/13/25.
//

import UIKit
import SnapKit
import Foundation

class ScheduleCell: UITableViewCell {

    static let identifier = "ScheduleCell"

    private let scheduleImageView : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 9.91
        return image
    }()
    private let scheduleTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .black
        return label
    }()
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .icon1
        return label
    }()

    private let scheduleCategoryLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .icon2
        return label
    }()
    private let participantsLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .icon2
        return label
    }()
    
    private let categoryImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arcade")
        return image
    }()
    
    private let friendsImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "friends")
        return image
    }()
    
    let deleteButton : UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.coffee, for: .normal)
        button.titleLabel?.font = .body3
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.backgroundColor = .blue6
        contentView.layer.borderColor = UIColor.blue1.cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true

        contentView.addSubview(scheduleImageView)
        contentView.addSubview(scheduleTitleLabel)
        contentView.addSubview(participantsLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(scheduleCategoryLabel)
        contentView.addSubview(categoryImageView)
        contentView.addSubview(friendsImageView)
        contentView.addSubview(deleteButton)


        scheduleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(39)
            make.width.height.equalTo(109)
        }

        scheduleTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalTo(scheduleImageView.snp.trailing).offset(24)
            make.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(scheduleTitleLabel.snp.leading)
            make.top.equalTo(scheduleTitleLabel.snp.bottom).offset(4)
            make.height.equalTo(16)
        }
        
        scheduleCategoryLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.centerY.equalTo(categoryImageView)
            make.leading.equalTo(categoryImageView.snp.trailing).offset(8)
        }
        
        participantsLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.centerY.equalTo(friendsImageView)
            make.leading.equalTo(scheduleCategoryLabel.snp.leading)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(13)
            make.leading.equalTo(scheduleImageView.snp.trailing).offset(24)
            make.width.height.equalTo(16)
        }
        
        friendsImageView.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.leading)
            make.top.equalTo(categoryImageView.snp.bottom).offset(3)
            make.width.height.equalTo(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(23)
            make.width.equalTo(28)
            make.height.equalTo(19)
        }

    }
    // `configure(with:)` 메서드 추가 (올바른 타입 사용)
    func configure(with schedule: Schedule) {
        scheduleImageView.image = UIImage(named: schedule.image)
        scheduleTitleLabel.text = schedule.title
        scheduleCategoryLabel.text = "\(schedule.category)"
        participantsLabel.text = " \(schedule.participants.joined(separator: ""))"
        locationLabel.text = "\(schedule.location)"
    }
    
}

import Foundation

struct Schedule {
    let image: String        // 일정 썸네일 이미지 (assets의 이미지 이름)
    let title: String        // 일정 제목
    let subtitle: String     // 일정 설명
    let location: String    // 일정을 만든 사람
    let category: String     // 일정 분류 (카테고리)
    let participants: [String] // 일정에 함께할 친구들
}

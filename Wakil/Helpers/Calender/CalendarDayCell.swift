//
//  CalendarDayCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {

    private let dayLabel = UILabel()
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(nameLabel)

        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dayLabel.clipsToBounds = true

        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        nameLabel.textColor = .darkGray

        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: 32),
            dayLabel.heightAnchor.constraint(equalToConstant: 32),

            nameLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with day: CalendarDay, isSelected: Bool, isToday: Bool) {
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.dateFormat = "EEEE"

        dayLabel.text = "\(calendar.component(.day, from: day.date))"
        nameLabel.text = formatter.string(from: day.date)

        if isSelected {
            dayLabel.backgroundColor = R.color.normalblue()
            dayLabel.textColor = .white
            dayLabel.layer.cornerRadius = 16
            dayLabel.layer.borderWidth = 0
        } else {
            dayLabel.backgroundColor = .clear
            dayLabel.textColor = .label
            dayLabel.layer.cornerRadius = 16
            dayLabel.layer.borderWidth = 2
            dayLabel.borderColor = UIColor(hex: "#EBEBEB")
        }
    }
}

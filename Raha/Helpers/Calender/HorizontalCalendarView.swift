//
//  HorizontalCalendarView.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

@IBDesignable
class HorizontalCalendarView: UIView {

    private let monthLabel = UILabel()
    private let calendarIcon = UIImageView(image: UIImage(named: "Calendar Remove"))
    private let collectionView: UICollectionView

        private var days: [CalendarDay] = []
        var selectedDate: Date?

    @IBInspectable var localeIdentifier: String = "lang".localized {
            didSet { loadDates() }
        }

        override init(frame: CGRect) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder: NSCoder) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            super.init(coder: coder)
            commonInit()
        }
        var onDateSelected: ((Date) -> Void)?

        private func commonInit() {
            setupViews()
            updateSemanticDirection()
            loadDates()
        }
    private func updateSemanticDirection() {
           let isRTL = Locale.characterDirection(forLanguage: localeIdentifier) == .rightToLeft
           self.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
           self.collectionView.semanticContentAttribute = self.semanticContentAttribute
           self.monthLabel.textAlignment = isRTL ? .right : .left
       }
        private func setupViews() {
            calendarIcon.contentMode = .scaleAspectFit

                monthLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                monthLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

                collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
                collectionView.dataSource = self
                collectionView.delegate = self
                collectionView.backgroundColor = .clear
                collectionView.showsHorizontalScrollIndicator = false

                // Stack to contain calendarIcon and monthLabel
                let stack = UIStackView(arrangedSubviews: [monthLabel, calendarIcon])
                stack.axis = .horizontal
                stack.alignment = .center
                stack.spacing = 8
                stack.translatesAutoresizingMaskIntoConstraints = false

                addSubview(stack)
                addSubview(collectionView)
                collectionView.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                    stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                    stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

                    // Set the calendarIcon size
                    calendarIcon.widthAnchor.constraint(equalToConstant: 20),
                    calendarIcon.heightAnchor.constraint(equalToConstant: 20),

                    // Set the collectionView position
                    collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12),
                    collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    collectionView.heightAnchor.constraint(equalToConstant: 64)
                ])
        }

        private func loadDates() {
            let calendar = Calendar.current
            let today = Date()
            selectedDate = today
            onDateSelected?(selectedDate ?? Date())
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: localeIdentifier)
            dateFormatter.dateFormat = "MMMM yyyy"
            monthLabel.text = dateFormatter.string(from: today)

            days = (0..<30).compactMap {
                calendar.date(byAdding: .day, value: $0, to: today).map { CalendarDay(date: $0) }
            }

            collectionView.reloadData()
        }

        private func updateMonthLabel() {
            guard let selected = selectedDate else { return }
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: localeIdentifier)
            formatter.dateFormat = "MMMM yyyy"
            monthLabel.text = formatter.string(from: selected)
        }
    }

    extension HorizontalCalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return days.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as? CalendarDayCell else {
                return UICollectionViewCell()
            }

            let day = days[indexPath.item]
            let isToday = Calendar.current.isDateInToday(day.date)
            let isSelected = Calendar.current.isDate(day.date, inSameDayAs: selectedDate ?? Date())
            cell.configure(with: day, isSelected: isSelected, isToday: isToday)
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedDate = days[indexPath.item].date
            if let selectedDate = selectedDate {
                onDateSelected?(selectedDate)
            }
            collectionView.reloadData()
            updateMonthLabel()
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 48, height: 56)
        }
    }

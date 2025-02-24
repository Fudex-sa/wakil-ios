//
//  CalendarPickerView.swift
//  CalendarDateRangePickerViewController
//
//  Created by M.abdu on 29/11/2021.
//

import Foundation
import UIKit

@IBDesignable
public class CalendarPickerView: UIView, CustomViewNibLoadable {
    
    @IBOutlet internal weak var containerView: UIView!
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    
    private let cellReuseIdentifier = "CalendarDateRangePickerCell"
    private let headerReuseIdentifier = "CalendarDateRangePickerHeaderView"
    
    private var currentSection: Int = 0
    private var minimumDate: Date!
    private var maximumDate: Date!
    private var selectedEndDate: Date?
    private var selectedStartDate: Date? {
        get {
            return selectedDates.first
        }
    }
    private var configration: Configration {
        get {
            return CalendarPickerView.configration
        }
    }
    
    public var selectedDates: [Date] = []
    public var selectedDefaultsDates: [Date] = [] {
        didSet {
            calendarCollectionView.reloadData()
        }
    }
    public static var configration: Configration = .init()
    public weak var delegate: CalendarPickerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        updateView()
        makeCollectionSwipeable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
        updateView()
        makeCollectionSwipeable()
    }
}
extension CalendarPickerView {
    func updateView() {
        calendarCollectionView?.dataSource = self
        calendarCollectionView?.delegate = self
        calendarCollectionView?.backgroundColor = configration.backgroundColor
        
        calendarCollectionView?.register(CalendarDateRangePickerCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        calendarCollectionView?.register(CalendarDateRangePickerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        calendarCollectionView?.contentInset = configration.collectionInsets
        
        if minimumDate == nil {
            minimumDate = Date()
        }
        if maximumDate == nil {
            maximumDate = Calendar.current.date(byAdding: .year, value: 3, to: minimumDate)
        }
    }
}
// sections
extension CalendarPickerView {
    func sections() -> Int {
        let difference = Calendar.current.dateComponents([.month], from: minimumDate, to: maximumDate).month ?? 0
        return difference + 1
    }
    func titleOfSection() -> String? {
        getMonthLabel(date: getFirstDateForSection(section: currentSection))
    }
}
// swipable
extension CalendarPickerView {
    func makeCollectionSwipeable() {
        if configration.direction == .vertical {
            return
        }
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.nextSection))
        gesture.direction = .left
        calendarCollectionView.addGestureRecognizer(gesture)

        let gesture1 = UISwipeGestureRecognizer(target: self, action: #selector(self.backSection))
        gesture1.direction = .right
        calendarCollectionView.addGestureRecognizer(gesture1)
        
    }
    @objc func nextSection() {
        if currentSection == sections() {
            return
        }
        currentSection += 1
        
        calendarCollectionView.layer.add(swipeTransition(direction: .left), forKey: nil)
        calendarCollectionView.reloadData()
    }
    @objc func backSection() {
        if currentSection == 0 {
            return
        }
        currentSection -= 1
        calendarCollectionView.layer.add(swipeTransition(direction: .right), forKey: nil)
        calendarCollectionView.reloadData()
    }
    func swipeTransition(direction: UISwipeGestureRecognizer.Direction?) -> CATransition {
        let transition = CATransition()
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = .push
        
        if direction == .left {
            transition.subtype = .fromRight
        } else if direction == .right {
            transition.subtype = .fromLeft
        }
        transition.duration = 0.3
        return transition
    }
}
extension CalendarPickerView: UICollectionViewDataSource {
    // UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if configration.direction == .horizontal {
            return 1

        } else {
            return sections()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if configration.direction == .vertical {
            currentSection = section
        }
        let firstDateForSection = getFirstDateForSection(section: currentSection)
        let weekdayRowItems = 7
        let blankItems = getWeekday(date: firstDateForSection) - 1
        let daysInMonth = getNumberOfDaysInMonth(date: firstDateForSection)
        return weekdayRowItems + blankItems + daysInMonth
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if configration.direction == .vertical {
            currentSection = indexPath.section
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CalendarDateRangePickerCell
        cell.label.font = configration.daysTitleFont
        cell.label.textColor = configration.daysTitleColor
        cell.reset()
        let blankItems = getWeekday(date: getFirstDateForSection(section: currentSection)) - 1
        if indexPath.item < 7 {
            cell.label.text = getWeekdayLabel(weekday: indexPath.item + 1)
            cell.label.textColor = configration.weekDaysTitleColor
            cell.backgroundColor = configration.weekDaysBackgroundColor
        } else if indexPath.item < 7 + blankItems {
            cell.label.text = ""
        } else {
            let dayOfMonth = indexPath.item - (7 + blankItems) + 1
            let date = getDate(dayOfMonth: dayOfMonth, section: currentSection)
            cell.date = date
            cell.label.text = "\(dayOfMonth)"
            
            if selectedDefaultsDates.contains(date) && areSameDay(dateA: date, dateB: date) {
                cell.selectDefaultDate()
            }
            if configration.behavior == .after {
                if isBefore(dateA: date, dateB: minimumDate) {
                    cell.disable()
                }
            }
            
            
            switch configration.selection {
            case .single:
                if selectedStartDate != nil && areSameDay(dateA: date, dateB: selectedStartDate!) {
                    // Cell is selected start date
                    cell.select()
                }
            case .range:
                if selectedStartDate != nil && selectedEndDate != nil && isBefore(dateA: selectedStartDate!, dateB: date) && isBefore(dateA: date, dateB: selectedEndDate!) {
                    // Cell falls within selected range
                    if dayOfMonth == 1 {
                        cell.highlightRight()
                    } else if dayOfMonth == getNumberOfDaysInMonth(date: date) {
                        cell.highlightLeft()
                    } else {
                        cell.highlight()
                    }
                } else if selectedStartDate != nil && areSameDay(dateA: date, dateB: selectedStartDate!) {
                    // Cell is selected start date
                    cell.select()
                    if selectedEndDate != nil {
                        cell.highlightRight()
                    }
                } else if selectedEndDate != nil && areSameDay(dateA: date, dateB: selectedEndDate!) {
                    cell.select()
                    cell.highlightLeft()
                }
            case .multiable:
                if selectedDates.contains(date) && areSameDay(dateA: date, dateB: date) {
                    // Cell is selected start date
                    cell.select()
                }
                break
            }
        }
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if configration.direction == .vertical {
            currentSection = indexPath.section
        }
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! CalendarDateRangePickerHeaderView
            headerView.titleLbl.font = configration.monthTitleFont
            headerView.titleLbl.textColor = configration.monthTitleColor
            headerView.titleLbl.text = getMonthLabel(date: getFirstDateForSection(section: currentSection))
            headerView.nextBtn.setImage(configration.nextImage, for: .normal)
            headerView.backBtn.setImage(configration.backImage, for: .normal)
            headerView.nextBtn.tintColor = configration.nextImageTintColor
            headerView.backBtn.tintColor = configration.backImageTintColor
            headerView.nextBtn.addTarget(self, action: #selector(self.nextSection), for: .touchUpInside)
            headerView.backBtn.addTarget(self, action: #selector(self.backSection), for: .touchUpInside)
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
}

extension CalendarPickerView : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarDateRangePickerCell
        if cell.date == nil {
            return
        }
        if configration.behavior == .after {
            if isBefore(dateA: cell.date!, dateB: minimumDate) {
                return
            }
        }
        guard let date = cell.date else { return }
        switch configration.selection {
        case .single:
            selectedDates.removeAll()
            selectedDates.append(date)
            selectedEndDate = nil
            self.delegate?.calendarPicker(self, didPick: date)
        case .range:
            //selectedDates.removeAll()
            if selectedStartDate == nil {
                selectedDates.removeAll()
                selectedDates.append(date)
            } else if selectedEndDate == nil {
                if isBefore(dateA: selectedStartDate!, dateB: cell.date!) {
                    selectedEndDate = cell.date
                    guard let fromDate = selectedStartDate, let toDate = selectedEndDate else { return }
                    self.delegate?.calendarPicker(self, didPickRange: fromDate, end: toDate)
                    //self.navigationItem.rightBarButtonItem?.isEnabled = true
                } else {
                    // If a cell before the currently selected start date is selected then just set it as the new start date
                    selectedDates.removeAll()
                    selectedDates.append(date)
                }
            } else {
                selectedDates.removeAll()
                selectedDates.append(date)
                selectedEndDate = nil
            }
        case .multiable:
            if selectedDates.contains(date) {
                selectedDates.removeAll(date)
            } else {
                selectedDates.append(date)
            }
            self.delegate?.calendarPicker(self, didMultiablePick: selectedDates)
            break
        }
       
        collectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = configration.collectionInsets.left + configration.collectionInsets.right
        let availableWidth = containerView.frame.width - padding
        let itemWidth = availableWidth / CGFloat(configration.itemsPerRow)
        return CGSize(width: itemWidth, height: configration.itemHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: containerView.frame.size.width, height: 50)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension CalendarPickerView {
    
    // Helper functions
    
    func getFirstDate() -> Date {
        var components = Calendar.current.dateComponents([.month, .year], from: minimumDate)
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    func getFirstDateForSection(section: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: section, to: getFirstDate())!
    }
    
    func getMonthLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getWeekdayLabel(weekday: Int) -> String {
        var components = DateComponents()
        components.calendar = Calendar.current
        components.weekday = weekday
        let date = Calendar.current.nextDate(after: Date(), matching: components, matchingPolicy: Calendar.MatchingPolicy.strict)
        if date == nil {
            return "E"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date!)
    }
    
    func getWeekday(date: Date) -> Int {
        return Calendar.current.dateComponents([.weekday], from: date).weekday!
    }
    
    func getNumberOfDaysInMonth(date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)!.count
    }
    
    func getDate(dayOfMonth: Int, section: Int) -> Date {
        var components = Calendar.current.dateComponents([.month, .year], from: getFirstDateForSection(section: section))
        components.day = dayOfMonth
        return Calendar.current.date(from: components)!
    }
    
    func areSameDay(dateA: Date, dateB: Date) -> Bool {
        return Calendar.current.compare(dateA, to: dateB, toGranularity: .day) == ComparisonResult.orderedSame
    }
    
    func isBefore(dateA: Date, dateB: Date) -> Bool {
        return Calendar.current.compare(dateA, to: dateB, toGranularity: .day) == ComparisonResult.orderedAscending
    }
    
}

//
//  CalendarDelegate.swift
//  CalendarDateRangePickerViewController_Example
//
//  Created by M.abdu on 29/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

public protocol CalendarPickerDelegate: NSObjectProtocol {
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didCancel: Bool)
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didMultiablePick dates: [Date])
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didPick date: Date)
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didPickRange start: Date, end: Date)
}

extension CalendarPickerDelegate {
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didCancel: Bool) { }
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didMultiablePick dates: [Date]) { }
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didPick date: Date) { }
    func calendarPicker(_ calendarPickerView: CalendarPickerView, didPickRange start: Date, end: Date) { }
}

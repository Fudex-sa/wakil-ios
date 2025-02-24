//
//  Configuration.swift
//  CalendarDateRangePickerViewController_Example
//
//  Created by M.abdu on 29/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
public extension CalendarPickerView {
    struct Configration {
        var backgroundColor: UIColor? = .clear
        var nextImage: UIImage?
        var nextImageTintColor: UIColor?
        var backImage: UIImage?
        var backImageTintColor: UIColor?
        var monthTitleColor: UIColor? = R.color.black()
        var monthTitleFont: UIFont? = UIFont.systemFont(ofSize: 14)
        var weekDaysBackgroundColor: UIColor? = .clear
        var weekDaysTitleColor: UIColor? = R.color.black()
        var weekDaysTitleFont: UIFont? = UIFont.systemFont(ofSize: 14)
        var daysSelectedColor: UIColor? = R.color.txtblue()
        var defaultDaysSelectedColor: UIColor? = .lightGray
        var daysDiselectedColor: UIColor? = .lightGray
        var daysHighlightColor: UIColor? = .lightGray
        var daysTitleColor: UIColor? = R.color.black()
        var daysTitleSelectedColor: UIColor? = R.color.whiteColor()
        var daysTitleFont: UIFont? = UIFont.systemFont(ofSize: 14)
        var collectionInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var itemHeight: CGFloat = 40
        var itemsPerRow = 7
        var selection: Selection = .single
        var direction: Direction = .horizontal
        var behavior: Behavior = .after
        
        public enum Selection {
            case single
            case range
            case multiable
        }
        public enum Direction {
            case vertical
            case horizontal
        }
        public enum Behavior {
            case any
            case after
        }
    }
}

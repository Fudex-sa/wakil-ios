//
//  UISegmentedControl+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UISegmentedControl {
    /// A publisher emitting selected segment index changes for this segmented control.
    private var selectedSegmentIndexPublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.selectedSegmentIndex)
                  .eraseToAnyPublisher()
    }
    var publisher: AnyPublisher<Int, Never> {
        selectedSegmentIndexPublisher
    }
}

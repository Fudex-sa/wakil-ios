//
//  UISlider+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UISlider {
    /// A publisher emitting value changes for this slider.
    private var valuePublisher: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.value)
                  .eraseToAnyPublisher()
    }
    var publisher: AnyPublisher<Float, Never> {
        return valuePublisher
    }
}

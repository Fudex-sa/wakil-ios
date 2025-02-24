//
//  UISwitch+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UISwitch {
    /// A publisher emitting on status changes for this switch.
    private var isOnPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isOn)
                  .eraseToAnyPublisher()
    }
    var publisher: AnyPublisher<Bool, Never> {
        return isOnPublisher
    }
}

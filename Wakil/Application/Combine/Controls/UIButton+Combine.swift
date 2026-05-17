//
//  UIButton+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIButton {
    /// A publisher emitting tap events from this button.
    private var tapPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .touchUpInside)
    }
    var publisher: AnyPublisher<Void, Never> {
        return tapPublisher
    }
}



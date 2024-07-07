//
//  UIRefreshControl+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIRefreshControl {
    /// A publisher emitting refresh status changes from this refresh control.
    private var isRefreshingPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isRefreshing)
                  .eraseToAnyPublisher()
    }
    var publisher: AnyPublisher<Bool, Never> {
        isRefreshingPublisher
    }
}

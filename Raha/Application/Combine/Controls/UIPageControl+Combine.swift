//
//  UIPageControl+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIPageControl {
    /// A publisher emitting current page changes for this page control.
    private var currentPagePublisher: AnyPublisher<Int, Never> {
        publisher(for: \.currentPage).eraseToAnyPublisher()
    }
    var publisher: AnyPublisher<Int, Never> {
        currentPagePublisher
    }
}

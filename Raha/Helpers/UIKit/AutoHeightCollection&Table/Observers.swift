//
//  Observers.swift
//  Wndo
//
//  Created by Mabdu on 04/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

fileprivate var observers: [UIScrollView: NSKeyValueObservation?] = [:]

protocol UIScrollViewObserve: NSObjectProtocol {
    var observer: NSKeyValueObservation? { set get }
    func observe(with maxHeight: CGFloat?)
}

extension UIScrollView: UIScrollViewObserve {
    var observer: NSKeyValueObservation? {
        get {
            return observers[self] ?? nil
        }
        set {
            observers[self] = newValue
        }
    }
    func observe(with maxHeight: CGFloat? = nil) {
        observer = self.observe(\.contentSize) { scroll, value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let constraint = scroll.constraints.first(where: { $0.firstAttribute == .height }) {
                    if let maxHeight = maxHeight {
                        let height = scroll.contentSize.height
                        if height >= maxHeight {
                            constraint.constant = maxHeight
                        } else {
                            constraint.constant = height
                        }
                    } else {
                        constraint.constant = scroll.contentSize.height
                    }
                }
            }
        }
    }
    func observe(_ observeHandler: @escaping ((CGFloat) -> Void)) {
        observer = self.observe(\.contentSize) { scroll, value in
            observeHandler(scroll.contentSize.height)
        }
    }
}

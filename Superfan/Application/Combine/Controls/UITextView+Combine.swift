//
//  UITextField+Combine.swift
//  CombineCocoa
//
//  Created by Mohamed Abdu on 02/08/2019.
//  Copyright © 2020 Combine. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UITextView {
    /// A publisher emitting any text changes to a this text view.
    var valuePublisher: AnyPublisher<String?, Never> {
       Deferred { [weak textView = self] in
         textView?.textStorage
           .didProcessEditingRangeChangeInLengthPublisher
           .map { _ in textView?.text }
           .prepend(textView?.text)
           .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
       }
       .eraseToAnyPublisher()
     }

     var textPublisher: AnyPublisher<String?, Never> { valuePublisher }
}


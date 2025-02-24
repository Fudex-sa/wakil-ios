//
//  NSTextStorage+Combine.swift
//  Wndo
//
//  Created by Mohamed Abdu on 18/04/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import Combine
public extension NSTextStorage {
  /// Combine publisher for `NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)`
  var didProcessEditingRangeChangeInLengthPublisher: AnyPublisher<(editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int), Never> {
    let selector = #selector(NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:))

    return delegateProxy
      .interceptSelectorPublisher(selector)
      .map { args -> (editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int) in
          // swiftlint:disable force_cast
          let editedMask = NSTextStorage.EditActions(rawValue: args[1] as! UInt)
          let editedRange = (args[2] as! NSValue).rangeValue
          let delta = args[3] as! Int
          return (editedMask, editedRange, delta)
          // swiftlint:enable force_cast
      }
      .eraseToAnyPublisher()
  }

  private var delegateProxy: NSTextStorageDelegateProxy {
      .createDelegateProxy(for: self)
  }
}

private class NSTextStorageDelegateProxy: DelegateProxy, NSTextStorageDelegate, DelegateProxyType {
  func setDelegate(to object: NSTextStorage) {
    object.delegate = self
  }
}

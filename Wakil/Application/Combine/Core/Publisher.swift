//
//  Combine.swift
//  CombineExample
//
//  Created by Mabdu on 11/10/2021.
//

import Foundation
import Combine


// MARK: - ... Publisher
class Publisher<T>: NSObject, Combining, Template {
    var subscriptions = Set<AnyCancellable>()
    public private(set) var publisher: CurrentValueSubject<T?, PublisherError>!
    public var value: T? {
        return publisher.value
    }
    override init() {
        super.init()
        publisher = CurrentValueSubject<T?, PublisherError>(nil)
    }
}


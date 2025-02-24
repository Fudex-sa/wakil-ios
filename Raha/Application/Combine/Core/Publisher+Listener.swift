//
//  Publisher+Listener.swift
//  CombineExample
//
//  Created by Mabdu on 11/10/2021.
//

import Foundation
import Combine

extension Publisher: Listener {
    func listen(receiveCompletion: @escaping ((Subscribers.Completion<PublisherError>) -> Void), receiveValue: @escaping ((T?) -> Void)) {
        publisher?.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue).store(in: &subscriptions)
    }
    func listen(error on: @escaping ((Subscribers.Completion<PublisherError>) -> Void)) {
        publisher?.sink(receiveCompletion: on, receiveValue: { _ in }).store(in: &subscriptions)
    }
    
    func listen(on value: @escaping ((T?) -> Void)) {
        publisher?.sink(receiveCompletion: { _ in }, receiveValue: { output in
            if output == nil {
                return
            }
            value(output)
        
        }).store(in: &subscriptions)
    }
}


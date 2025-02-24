//
//  Publisher+Sender.swift
//  CombineExample
//
//  Created by Mabdu on 11/10/2021.
//

import Foundation


extension Publisher: Sender {
    func send(_ input: T) {
        publisher?.send(input)
    }
    func send(error: PublisherError) {
        publisher?.send(completion: .failure(error))
    }
}

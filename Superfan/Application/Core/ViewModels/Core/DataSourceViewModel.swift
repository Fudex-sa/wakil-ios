//
//  DataSourceViewModel.swift
//  Wndo
//
//  Created by M.abdu on 06/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

protocol DataSourceViewModel: NSObjectProtocol {
    associatedtype T
    var items: Publisher<[T]> { get set }
    func clearDataSource()
    func dataSource() -> [T]?
    func count() -> Int
    func append(contentsOf: [T])
    func append(_ newElement: T)
}

extension DataSourceViewModel {
    func clearDataSource() {
        guard var value = items.value else { return }
        value.removeAll()
        items.send(value)
    }
    func dataSource() -> [T]? {
        guard let value = items.value else { return nil }
        if value.count == 0 {
            return nil
        } else {
            return value
        }
    }
    func count() -> Int {
        guard let value = items.value else { return 0 }
        if value.count == 0 {
            return 0
        } else {
            return value.count
        }
    }
    func append(contentsOf: [T]) {
        var dataSource = dataSource() ?? []
        dataSource.append(contentsOf: contentsOf)
        items.send(dataSource)
    }
    func append(_ newElement: T) {
        var dataSource = dataSource() ?? []
        dataSource.append(newElement)
        items.send(dataSource)
    }
    func replace(_ newElement: T, forIndexPath: Int) {
        var dataSource = dataSource() ?? []
        if dataSource.isset(forIndexPath) {
            dataSource.remove(at: forIndexPath)
            dataSource.insert(newElement, at: forIndexPath)
        }
        items.send(dataSource)
    }
    func insert(_ newElement: T, forIndexPath: Int) {
        var dataSource = dataSource() ?? []
        dataSource.insert(newElement, at: forIndexPath)
        items.send(dataSource)
    }
    func remove(forIndexPath: Int) {
        var dataSource = dataSource() ?? []
        if dataSource.isset(forIndexPath) {
            dataSource.remove(at: forIndexPath)
            items.send(dataSource)
        }
    }
}

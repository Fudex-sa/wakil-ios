//
//  MypostsViewModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class MypostsViewModel: BaseViewModel , DataSourceViewModel{
    var items: Publisher<[PostsDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension MypostsViewModel {
}
// MARK: - ...  Example of network response
extension MypostsViewModel {
    func fetchposts() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.myposts.rawValue, type: .get, PostsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

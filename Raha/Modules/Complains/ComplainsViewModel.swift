//
//  ComplainsViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ComplainsViewModel: BaseViewModel  ,DataSourceViewModel {
    var status: Publisher<Int> = .init()
    var items: Publisher<[ComplainsDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension ComplainsViewModel {
}
// MARK: - ...  Example of network response
extension ComplainsViewModel {
    func fetchcomplains() {
        if status.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["status"] = status.value ?? ""
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.compalins.rawValue, type: .get, ComplainsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

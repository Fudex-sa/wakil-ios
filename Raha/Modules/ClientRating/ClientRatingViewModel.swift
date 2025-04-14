//
//  ClientRatingViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ClientRatingViewModel: BaseViewModel ,DataSourceViewModel {
    var centerId: Publisher<Int> = .init()
    var items: Publisher<[RatingDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension ClientRatingViewModel {
}
// MARK: - ...  Example of network response
extension ClientRatingViewModel {
    func fetchrating() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.home.rawValue)/\(centerId.value ?? 0)/rate", type: .get, ClientRatingModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

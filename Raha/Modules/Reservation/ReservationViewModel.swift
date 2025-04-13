//
//  ReservationViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ReservationViewModel: BaseViewModel ,DataSourceViewModel {
    var status: Publisher<Int> = .init()
    var items: Publisher<[ReservationDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension ReservationViewModel {
}
// MARK: - ...  Example of network response
extension ReservationViewModel {
    func fetchorders() {
        NetworkManager.instance.paramaters["status"] = status.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.myorders.rawValue, type: .get, ReservationModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

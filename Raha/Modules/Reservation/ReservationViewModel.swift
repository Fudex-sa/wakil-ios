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
        var statuses: [Int] = []
        statuses.append(status.value ?? 0)
        if status.value ?? 0 == 4 {
            statuses.append(5)
        }
        NetworkManager.instance.paramaters["statuses"] = statuses
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

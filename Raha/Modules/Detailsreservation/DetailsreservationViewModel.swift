//
//  DetailsreservationViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class DetailsreservationViewModel: BaseViewModel{
    var orderId: Publisher<Int> = .init()
    var orderdetails: Publisher<DetailsreservationModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension DetailsreservationViewModel {
}
// MARK: - ...  Example of network response
extension DetailsreservationViewModel {
    func fetchorderdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.orderdetails.rawValue)\(orderId.value ?? 0)", type: .get, DetailsreservationModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.orderdetails.send(model)
        }).store(self)
    }
}

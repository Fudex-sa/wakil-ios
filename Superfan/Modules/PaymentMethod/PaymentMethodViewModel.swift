//
//  PaymentMethodViewModel.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class PaymentMethodViewModel: BaseViewModel  , DataSourceViewModel{
    var items: Publisher<[PaymentMethodDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension PaymentMethodViewModel {
}
// MARK: - ...  Example of network response
extension PaymentMethodViewModel {
    func fetchpayments() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.paymentMethods.rawValue, type: .get, PaymentMethodModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

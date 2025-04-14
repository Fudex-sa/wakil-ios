//
//  CancelOrderViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class CancelOrderViewModel: BaseViewModel {
    var policyddata: Publisher<AboutusModel> = .init()

}
// MARK: - ...  ViewModel Contract
extension CancelOrderViewModel {
}
// MARK: - ...  Example of network response
extension CancelOrderViewModel {
    func getcancelpolicy() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.cancelpolicy.rawValue, type: .get, AboutusModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.policyddata.send(model)
        }).store(self)
    }
}

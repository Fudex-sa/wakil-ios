//
//  CancelPopupViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class CancelPopupViewModel: BaseViewModel {
    var orderId: Publisher<Int> = .init()
    var canceldata: Publisher<UserRoot> = .init()

}
// MARK: - ...  ViewModel Contract
extension CancelPopupViewModel {
}
// MARK: - ...  Example of network response
extension CancelPopupViewModel {
    func fetchcancel() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.orderdetails.rawValue)\(orderId.value ?? 0)/cancel", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.canceldata.send(model)
        }).store(self)
    }
}

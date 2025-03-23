//
//  SelectAddressViewModel.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class SelectAddressViewModel: BaseViewModel ,DataSourceViewModel {
    var items: Publisher<[AddressesDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension SelectAddressViewModel {
}
// MARK: - ...  Example of network response
extension SelectAddressViewModel {
    func fetchaddresses() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.addresses.rawValue, type: .get, AddressesModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

//
//  AddressViewModel.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class AddressViewModel: BaseViewModel ,DataSourceViewModel {
    var addressId: Publisher<Int> = .init()
    var items: Publisher<[AddressesDatum]> = .init()
    var deltedata: Publisher<DeleteaddresssModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension AddressViewModel {
}
// MARK: - ...  Example of network response
extension AddressViewModel {
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
    func deleteaddress() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.addresses.rawValue)/\(addressId.value ?? 0)/delete", type: .post, DeleteaddresssModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deltedata.send(model)
        }).store(self)
    }
    
    func defultaddress() {
        NetworkManager.instance.paramaters["is_default"] = 1
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.addresses.rawValue)/\(addressId.value ?? 0)/setDefault", type: .post, DeleteaddresssModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var index = 0
            var address :AddressesDatum?
            for item in self?.dataSource() ?? [] {
                address = item
                if item.isDefault ?? 0 == 1 && item.id != self?.addressId.value ?? 0 {
                    address?.isDefault = 0
                    self?.replace(address!, forIndexPath: index)
                }
                if item.id == self?.addressId.value ?? 0 {
                    address?.isDefault = 1
                    self?.replace(address!, forIndexPath: index)
                }
                index = index + 1
            }
            self?.publisher()
        }).store(self)
    }
}

//
//  HomeViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class HomeViewModel: BaseViewModel ,DataSourceViewModel {
    var items: Publisher<[AddressesDatum]> = .init()
    var userddata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension HomeViewModel {
}
// MARK: - ...  Example of network response
extension HomeViewModel {
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
    func getprofile() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.profile.rawValue, type: .get, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.userddata.send(model)
        }).store(self)
    }
}

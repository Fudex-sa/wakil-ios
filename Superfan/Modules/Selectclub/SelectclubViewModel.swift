//
//  SelectclubViewModel.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class SelectclubViewModel: BaseViewModel , DataSourceViewModel{
    var countryId: Publisher<Int> = .init()
    var items: Publisher<[SelectclubDatum]> = .init()
    var clubId: Publisher<Int> = .init()
    var favclub: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension SelectclubViewModel {
}
// MARK: - ...  Example of network response
extension SelectclubViewModel {
    func fetchclubs() {
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.clubs.rawValue, type: .get, SelectclubModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func makefavcliub() {
        NetworkManager.instance.paramaters["club_id"] = clubId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.favclub.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.favclub.send(model)
        }).store(self)
    }
}

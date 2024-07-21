//
//  HomeViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class HomeViewModel: BaseViewModel , DataSourceViewModel{
    var countryId: Publisher<Int> = .init()
    var clubId: Publisher<Int> = .init()
    var items: Publisher<[NewsModelData]> = .init()
    var clubs: Publisher<[SelectclubDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension HomeViewModel {
}
// MARK: - ...  Example of network response
extension HomeViewModel {
    func fetchhome() {
        if UD.club != nil {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.paramaters["limit"] = 4
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.home.rawValue, type: .get, HomeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data?.news ?? [])
            self?.clubs.send(model.data?.clubs ?? [])
            self?.paginator(respnod: model.data?.news)
            self?.publisher()
        }).store(self)
    }
}

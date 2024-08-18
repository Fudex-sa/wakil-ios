//
//  MatchesMoreViewModel.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class MatchesMoreViewModel: BaseViewModel , DataSourceViewModel{
    var clubId: Publisher<Int> = .init()
    var items: Publisher<[MatchsDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension MatchesMoreViewModel {
}
// MARK: - ...  Example of network response
extension MatchesMoreViewModel {
    func fetchtodaymatch() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.todaymatxh.rawValue, type: .get, MatchsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func fetchperviousymatch() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.perviousmatch.rawValue, type: .get, MatchsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

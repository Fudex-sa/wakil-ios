//
//  MatchdetailsViewModel.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class MatchdetailsViewModel: BaseViewModel {
    var matchId: Publisher<Int> = .init()
    var matchdata: Publisher<MatchdetailsModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension MatchdetailsViewModel {
}
// MARK: - ...  Example of network response
extension MatchdetailsViewModel {
    func getmatchdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.matches.rawValue)/\(matchId.value ?? 0)", type: .get, MatchdetailsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.matchdata.send(model)
        }).store(self)
    }
}

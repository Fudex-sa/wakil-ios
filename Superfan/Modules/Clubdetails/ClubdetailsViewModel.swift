//
//  ClubdetailsViewModel.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ClubdetailsViewModel: BaseViewModel {
    var clubId: Publisher<Int> = .init()
    var clubdata: Publisher<ClubdetailsModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension ClubdetailsViewModel {
}
// MARK: - ...  Example of network response
extension ClubdetailsViewModel {
    func getclubdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.clubs.rawValue)/\(clubId.value ?? 0)", type: .get, ClubdetailsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.clubdata.send(model)
        }).store(self)
    }
}

//
//  ChangeClubViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ChangeClubViewModel: BaseViewModel , DataSourceViewModel{
    var countryId: Publisher<Int> = .init()
    var items: Publisher<[SelectclubDatum]> = .init()
}
// MARK: - ...  ViewModel Contract
extension ChangeClubViewModel {
}
// MARK: - ...  Example of network response
extension ChangeClubViewModel {
    func fetchclubs() {
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.clubs.rawValue, type: .get, SelectclubModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            if self?.items.value?.count ?? 0 == 0 {
                if UD.user != nil {
                    if UD.user?.data?.user?.club != nil {
                        let club = SelectclubDatum(id: 0 ,name: "All".localized,color: UD.user?.data?.user?.club?.color ?? "#E51D35", photo: "")
                        self?.append(club)
                    }else {
                        let club = SelectclubDatum(id: 0 ,name: "All".localized,color: "#E51D35", photo: "")
                        self?.append(club)
                    }
                }else {
                    let club = SelectclubDatum(id: 0 ,name: "All".localized,color: "#E51D35", photo: "")
                    self?.append(club)
                }
            }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}

//
//  DetailscentersViewModel.swift
//  Raha
//
//  Created by ADAM on 27/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class DetailscentersViewModel: BaseViewModel {
    var lat: Publisher<Double> = .init()
    var lng: Publisher<Double> = .init()
    var servicetype: Publisher<String> = .init()
    var centerId: Publisher<Int> = .init()
    var centerdetails: Publisher<DetailscentersModel> = .init()
    var loctype: Publisher<String> = .init()

}
// MARK: - ...  ViewModel Contract
extension DetailscentersViewModel {
}
// MARK: - ...  Example of network response
extension DetailscentersViewModel {
    func fetchcentersdetails() {
        NetworkManager.instance.paramaters["lat"] = lat.value ?? 0.0
        NetworkManager.instance.paramaters["lng"] = lng.value ?? 0.0
        if servicetype.value ?? "" != "" {
            NetworkManager.instance.paramaters["service_type"] = servicetype.value ?? ""
        }
        if loctype.value ?? "" != "" {
            NetworkManager.instance.paramaters["location_type"] = loctype.value ?? ""
        }
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.home.rawValue)/\(centerId.value ?? 0)", type: .get, DetailscentersModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.centerdetails.send(model)
        }).store(self)
    }
}

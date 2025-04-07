//
//  FilterServiceViewModel.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class FilterServiceViewModel: BaseViewModel {
    var servicestype: Publisher<[ServicetypeDatum]> = .init()
    var servicestypeFinished: Publisher<Bool> = .init()
}
// MARK: - ...  ViewModel Contract
extension FilterServiceViewModel {
}
// MARK: - ...  Example of network response
extension FilterServiceViewModel {
    func fetchservicestype() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.servicetype.rawValue, type: .get, ServicetypeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.servicestype.send(model.data ?? [])
            self?.servicestypeFinished.send(true)
        }).store(self)
    }
}

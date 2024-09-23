//
//  SubscriptionsViewModel.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class SubscriptionsViewModel: BaseViewModel , DataSourceViewModel{
    var packageId: Publisher<Int> = .init()
    var paymentId: Publisher<Int> = .init()
    var clubId: Publisher<Int> = .init()
    var items: Publisher<[PackageDatum]> = .init()
    var paymentdata: Publisher<PaymentModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension SubscriptionsViewModel {
}
// MARK: - ...  Example of network response
extension SubscriptionsViewModel {
    func fetchpackages() {
        if clubId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = clubId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.packages.rawValue, type: .get, PackageModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func subscribe() {
        NetworkManager.instance.paramaters["paymentMethod_id"] = paymentId.value ?? 0
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.packages.rawValue)/\(packageId.value ?? 0)/subscripe", type: .post, PaymentModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.paymentdata.send(model)
        }).store(self)
    }
}

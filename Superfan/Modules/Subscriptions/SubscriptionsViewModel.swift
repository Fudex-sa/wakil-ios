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
    var tax: Publisher<String> = .init()
    var clubId: Publisher<Int> = .init()
    var checkclubId: Publisher<Int> = .init()
    var items: Publisher<[PackageDatum]> = .init()
    var mysubscribe: Publisher<[MysubscribeDatum]> = .init()
    var mysubscribedata: Publisher<Bool> = .init()
    var paymentdata: Publisher<PaymentModel> = .init()
    var delete: Publisher<UserRoot> = .init()
    var checksubscribe: Publisher<ChecksubscribeModel> = .init()

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
            self?.tax.send(model.added_tax ?? "")
            self?.publisher()
        }).store(self)
    }
    func subscribe() {
//        NetworkManager.instance.paramaters["paymentMethod_id"] = paymentId.value ?? 0
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.packages.rawValue)/\(packageId.value ?? 0)/subscripe", type: .post, PaymentModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.paymentdata.send(model)
        }).store(self)
    }
    func fetchmypackages() {
       
        NetworkManager.instance.request(NetworkConfigration.EndPoint.mySubscriptions.rawValue, type: .get, MysubscribeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var itemsdata: [MysubscribeDatum] = []
            itemsdata.append(contentsOf: self?.mysubscribe.value ?? [])
            itemsdata.append(contentsOf: model.data ?? [])
            self?.mysubscribe.send(itemsdata)
            self?.mysubscribedata.send(true)
        }).store(self)
    }
    func deletesubscribe() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.Subscriptions.rawValue)/\(packageId.value ?? 0)/cancelSubscription", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.delete.send(model)
        }).store(self)
    }
    func fetchchecksubscribe() {
        if checkclubId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = checkclubId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.checkSubscriptionSellers.rawValue, type: .get, ChecksubscribeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.checksubscribe.send(model)
        }).store(self)
    }
}

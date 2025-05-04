//
//  NotificationViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class NotificationViewModel: BaseViewModel ,DataSourceViewModel {
    var items: Publisher<[NotificationDatum]> = .init()
    var deltedata: Publisher<DeleteaddresssModel> = .init()
    var total: Publisher<String> = .init()
}
// MARK: - ...  ViewModel Contract
extension NotificationViewModel {
}
// MARK: - ...  Example of network response
extension NotificationViewModel {
    func fetchnotifications() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.notifications.rawValue, type: .get, NotificationModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.total.send(model.pagination?.total?.string ?? "")
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func deletenot() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.deletenotification.rawValue)", type: .post, DeleteaddresssModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deltedata.send(model)
        }).store(self)
    }
}

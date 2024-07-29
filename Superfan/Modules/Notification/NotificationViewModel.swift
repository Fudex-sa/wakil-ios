//
//  NotificationViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class NotificationViewModel: BaseViewModel , DataSourceViewModel{
    var items: Publisher<[NotificationsDatum]> = .init()
    var readall: Publisher<NotificationsModel> = .init()

}
// MARK: - ...  ViewModel Contract
extension NotificationViewModel {
}
// MARK: - ...  Example of network response
extension NotificationViewModel {
    func fetchnotifications() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.notifications.rawValue, type: .get, NotificationsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func readallnotification() {
        NetworkManager.instance.paramaters["all"] = true
        NetworkManager.instance.request(NetworkConfigration.EndPoint.notifications.rawValue, type: .post, NotificationsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
        }).store(self)
    }
}


//
//  MoreViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class MoreViewModel: BaseViewModel {
    var userddata: Publisher<ProfileModel> = .init()
    var logout: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension MoreViewModel {
}
// MARK: - ...  Example of network response
extension MoreViewModel {
    func getprofile() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.profile.rawValue, type: .get, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.userddata.send(model)
        }).store(self)
    }
    func makelogout() {
        NetworkManager.instance.paramaters["device_id"] = Constants.DEVICEID
        NetworkManager.instance.request(NetworkConfigration.EndPoint.logout.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            UD.user = nil
            self?.logout.send(model)
        }).store(self)
    }
}

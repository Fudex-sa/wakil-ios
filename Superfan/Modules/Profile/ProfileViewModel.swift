//
//  ProfileViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ProfileViewModel: BaseViewModel {
    var userddata: Publisher<ProfileModel> = .init()
    var deletedata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension ProfileViewModel {
}
// MARK: - ...  Example of network response
extension ProfileViewModel {
    func getprofile() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.profile.rawValue, type: .get, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.userddata.send(model)
        }).store(self)
    }
    func deleteaccount() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.deleteaccount.rawValue, type: .get, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deletedata.send(model)
        }).store(self)
    }
}

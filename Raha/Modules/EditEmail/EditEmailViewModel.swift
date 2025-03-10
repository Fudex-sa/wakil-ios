//
//  EditEmailViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditEmailViewModel: BaseViewModel {
    var email: Publisher<String> = .init()
    var resenddata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditEmailViewModel {
}
// MARK: - ...  Example of network response
extension EditEmailViewModel {
    func resendotp() {
        NetworkManager.instance.paramaters["mobile"] = email.value ?? ""
        NetworkManager.instance.paramaters["type"] = "update_email"
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
}

//
//  EditPhoneViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditPhoneViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var resenddata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditPhoneViewModel {
}
// MARK: - ...  Example of network response
extension EditPhoneViewModel {
    func resendotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["type"] = "update_mobile"
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
}

//
//  ForgetpasswordViewModel.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ForgetpasswordViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var resenddata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension ForgetpasswordViewModel {
}
// MARK: - ...  Example of network response
extension ForgetpasswordViewModel {
    func resendotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.paramaters["type"] = "password_reset"
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
}

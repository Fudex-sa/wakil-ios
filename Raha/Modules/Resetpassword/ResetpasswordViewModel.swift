//
//  ResetpasswordViewModel.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ResetpasswordViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var otp: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var resetdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension ResetpasswordViewModel {
}
// MARK: - ...  Example of network response
extension ResetpasswordViewModel {
    func resetpass() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["otp"] = otp.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.paramaters["password"] = password.value ?? ""
        NetworkManager.instance.paramaters["password_confirmation"] = password.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.resetpass.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resetdata.send(model)
        }).store(self)
    }
}

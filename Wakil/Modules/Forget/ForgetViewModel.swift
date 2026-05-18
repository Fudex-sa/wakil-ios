//
//  ForgetViewModel.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ForgetViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var resenddata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension ForgetViewModel {
}
// MARK: - ...  Example of network response
extension ForgetViewModel {
    func resendotp() {
            NetworkManager.instance.paramaters["phone"] = phone.value ?? ""
            NetworkManager.instance.request(NetworkConfigration.EndPoint.forgetpass.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
                self?.error.send(error)
            }, receiveValue: { [weak self] model in
                guard let model = model else { return }
                self?.resenddata.send(model)
            }).store(self)
        }
}

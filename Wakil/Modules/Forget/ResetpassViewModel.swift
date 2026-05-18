//
//  ResetpassViewModel.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ResetpassViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var otp: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var resetdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension ResetpassViewModel {
}
// MARK: - ...  Example of network response
extension ResetpassViewModel {
    func resetpass() {
           NetworkManager.instance.paramaters["phone"] = phone.value ?? ""
           NetworkManager.instance.paramaters["password"] = password.value ?? ""
           NetworkManager.instance.request(NetworkConfigration.EndPoint.resetpass.rawValue, type: .patch, UserRoot.self)?.response(error: { [weak self] error in
               self?.error.send(error)
           }, receiveValue: { [weak self] model in
               guard let model = model else { return }
               self?.resetdata.send(model)
           }).store(self)
    }
}

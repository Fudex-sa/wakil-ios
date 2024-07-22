//
//  EditphoneViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditphoneViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var resenddata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditphoneViewModel {
}
// MARK: - ...  Example of network response
extension EditphoneViewModel {
    func resendotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotpupdatephone.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
}

//
//  LoginViewModel.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class LoginViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var userdata: Publisher<UserRoot> = .init()
    var socailId: Publisher<String> = .init()
    var socialType: Publisher<Int> = .init()
    var email: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var active: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension LoginViewModel {
}
// MARK: - ...  Example of network response
extension LoginViewModel {
    func login() {
        NetworkManager.instance.paramaters["phone"] = phone.value ?? ""
        NetworkManager.instance.paramaters["password"] = password.value ?? ""
        NetworkManager.instance.paramaters["device_type"] = Constants.FCMTYPE
        NetworkManager.instance.paramaters["token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["mac"] = Constants.DEVICEID
        if UD.type == 1 {
            NetworkManager.instance.paramaters["type"] = "client"
        }else if UD.type == 2 {
            NetworkManager.instance.paramaters["type"] = "provider"
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.login.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            UD.user = model
            self?.userdata.send(model)
        }).store(self)
    }
    func loginsocail() {
        NetworkManager.instance.paramaters["social_id"] = socailId.value ?? ""
        NetworkManager.instance.paramaters["social_type"] = socialType.value ?? ""
        NetworkManager.instance.paramaters["email"] = email.value ?? ""
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["device_type"] = Constants.FCMTYPE
        NetworkManager.instance.paramaters["fcm_token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["device_id"] = Constants.DEVICEID
        NetworkManager.instance.request(NetworkConfigration.EndPoint.socialLogin.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            if model.data != nil {
                UD.user = model
            }
            self?.userdata.send(model)
        }).store(self)
    }
}

//
//  RegisterViewModel.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class RegisterViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var socailType: Publisher<Int> = .init()
    var socailId: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var userdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension RegisterViewModel {
}
// MARK: - ...  Example of network response
extension RegisterViewModel {
    
    func checkregister() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["device_type"] = Constants.FCMTYPE
        NetworkManager.instance.paramaters["fcm_token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["device_id"] = Constants.DEVICEID
        if socailType.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["social_id"] = socailId.value ?? ""
            NetworkManager.instance.paramaters["social_type"] = socailType.value ?? ""
        }else {
            NetworkManager.instance.paramaters["password"] = password.value ?? ""
            NetworkManager.instance.paramaters["password_confirmation"] = password.value ?? ""
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.register.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            UD.user = model
            self?.userdata.send(model)
        }).store(self)
    }
}

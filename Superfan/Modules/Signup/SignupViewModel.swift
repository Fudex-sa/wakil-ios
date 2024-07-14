//
//  SignupViewModel.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class SignupViewModel: BaseViewModel , DataSourceViewModel{
    var items: Publisher<[RegisterModel]> = .init()
    var countryId: Publisher<Int> = .init()
    var countryCode: Publisher<String> = .init()
    var stateId: Publisher<Int> = .init()
    var phone: Publisher<String> = .init()
    var email: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var lat: Publisher<String> = .init()
    var lng: Publisher<String> = .init()
    var socailType: Publisher<Int> = .init()
    var socailId: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var userdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension SignupViewModel {
}
// MARK: - ...  Example of network response
extension SignupViewModel {
    func fetchstates() {
        NetworkManager.instance.paramaters["state_id"] = countryId.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.states.rawValue, type: .get, Registerstep1Model.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func checkregister() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["email"] = email.value ?? ""
        NetworkManager.instance.paramaters["city_id"] = stateId.value ?? 0
        NetworkManager.instance.paramaters["lat"] = lat.value ?? ""
        NetworkManager.instance.paramaters["lng"] = lng.value ?? ""
        NetworkManager.instance.paramaters["device_type"] = Constants.FCMTYPE
        NetworkManager.instance.paramaters["fcm_token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["device_id"] = Constants.DEVICEID
        if socailType.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["provider_token"] = socailId.value ?? ""
            NetworkManager.instance.paramaters["provider_type"] = socailType.value ?? ""
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

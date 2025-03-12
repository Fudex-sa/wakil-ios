//
//  VerifycodeViewModel.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class VerifycodeViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var type: Publisher<String> = .init()
    var otp: Publisher<String> = .init()
    var countryCode: Publisher<String> = .init()
    var userdata: Publisher<UserRoot> = .init()
    var resenddata: Publisher<ProfileModel> = .init()
    var editphonedata: Publisher<ProfileModel> = .init()
    var checkotp: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension VerifycodeViewModel {
    func confirmotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["otp"] = otp.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.confirmotp.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            UD.user = model
            self?.userdata.send(model)
        }).store(self)
    }
    func checkotprequest() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["otp"] = otp.value ?? ""
        NetworkManager.instance.paramaters["type"] = type.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.checkotp.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.checkotp.send(model)
        }).store(self)
    }
    func resendotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["type"] = type.value ?? ""
        NetworkManager.instance.paramaters["country_code"] = countryCode.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
    func editphone() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["otp"] = otp.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.updatephone.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var user = UD.user
            user?.data?.user = model.data
            UD.user = user
            self?.editphonedata.send(model)
        }).store(self)
    }
    func resendphoneotp() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["type"] = "update_mobile"
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
    func resendemaileotp() {
        NetworkManager.instance.paramaters["email"] = phone.value ?? ""
        NetworkManager.instance.paramaters["type"] = "update_email"
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendotp.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.resenddata.send(model)
        }).store(self)
    }
    func editemail() {
        NetworkManager.instance.paramaters["email"] = phone.value ?? ""
        NetworkManager.instance.paramaters["otp"] = otp.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.updateemail.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var user = UD.user
            user?.data?.user = model.data
            UD.user = user
            self?.editphonedata.send(model)
        }).store(self)
    }
}
// MARK: - ...  Example of network response
extension VerifycodeViewModel {
    
}

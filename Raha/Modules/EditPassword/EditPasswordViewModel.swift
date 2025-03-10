//
//  EditPasswordViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditPasswordViewModel: BaseViewModel {
    var oldpassword: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var editpassdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditPasswordViewModel {
}
// MARK: - ...  Example of network response
extension EditPasswordViewModel {
    func editpass() {
        NetworkManager.instance.paramaters["current_password"] = oldpassword.value ?? ""
        NetworkManager.instance.paramaters["password"] = password.value ?? ""
        NetworkManager.instance.paramaters["password_confirmation"] = password.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.updatepassword.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.editpassdata.send(model)
        }).store(self)
    }
}

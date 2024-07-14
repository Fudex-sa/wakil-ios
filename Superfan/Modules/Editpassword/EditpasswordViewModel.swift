//
//  EditpasswordViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditpasswordViewModel: BaseViewModel {
    var oldpassword: Publisher<String> = .init()
    var password: Publisher<String> = .init()
    var editpassdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditpasswordViewModel {
}
// MARK: - ...  Example of network response
extension EditpasswordViewModel {
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


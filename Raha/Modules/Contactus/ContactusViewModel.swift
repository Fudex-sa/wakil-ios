//
//  ContactusViewModel.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ContactusViewModel: BaseViewModel {
    var email: Publisher<String> = .init()
    var message: Publisher<String> = .init()
    var contact: Publisher<DeleteaddresssModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension ContactusViewModel {
}
// MARK: - ...  Example of network response
extension ContactusViewModel {
    func sendMessage() {
        NetworkManager.instance.paramaters["email"] = email.value ?? ""
        NetworkManager.instance.paramaters["message"] = message.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.contactus.rawValue, type: .post, DeleteaddresssModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.contact.send(model)
        }).store(self)
    }
}

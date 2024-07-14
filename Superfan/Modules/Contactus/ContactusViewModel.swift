//
//  ContactusViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class ContactusViewModel: BaseViewModel {
    var phone: Publisher<String> = .init()
    var message: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var contact: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension ContactusViewModel {
}
// MARK: - ...  Example of network response
extension ContactusViewModel {
    func sendMessage() {
        NetworkManager.instance.paramaters["mobile"] = phone.value ?? ""
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["message"] = message.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.contactus.rawValue, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.contact.send(model)
        }).store(self)
    }
}

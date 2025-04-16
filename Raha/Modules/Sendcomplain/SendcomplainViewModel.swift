//
//  SendcomplainViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class SendcomplainViewModel: BaseViewModel {
    var type: Publisher<String> = .init()
    var message: Publisher<String> = .init()
    var contact: Publisher<DeleteaddresssModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension SendcomplainViewModel {
}
// MARK: - ...  Example of network response
extension SendcomplainViewModel {
    func sendMessage() {
        NetworkManager.instance.paramaters["type"] = type.value ?? ""
        NetworkManager.instance.paramaters["message"] = message.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sendcompalin.rawValue, type: .post, DeleteaddresssModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.contact.send(model)
        }).store(self)
    }
}

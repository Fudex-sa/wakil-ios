//
//  EditemailViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class EditemailViewModel: BaseViewModel {
    var email: Publisher<String> = .init()
    var editemaildata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditemailViewModel {
}
// MARK: - ...  Example of network response
extension EditemailViewModel {
    func editemail() {
        NetworkManager.instance.paramaters["email"] = email.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.updateemail.rawValue, type: .post, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            let user = UD.user
            user?.data?.user = model.data
            UD.user = user
            self?.editemaildata.send(model)
        }).store(self)
    }
}

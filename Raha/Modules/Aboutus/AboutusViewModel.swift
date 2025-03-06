//
//  AboutusViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class AboutusViewModel: BaseViewModel {
    var aboutddata: Publisher<AboutusModel> = .init()

}
// MARK: - ...  ViewModel Contract
extension AboutusViewModel {
}
// MARK: - ...  Example of network response
extension AboutusViewModel {
    func getabout() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.about.rawValue, type: .get, AboutusModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.aboutddata.send(model)
        }).store(self)
    }
}

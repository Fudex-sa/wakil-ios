//
//  TermsViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class TermsViewModel: BaseViewModel {
    var aboutddata: Publisher<AboutusModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension TermsViewModel {
}
// MARK: - ...  Example of network response
extension TermsViewModel {
    func getterms() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.terms.rawValue, type: .get, AboutusModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.aboutddata.send(model)
        }).store(self)
    }
    func getprivacy() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.privacy.rawValue, type: .get, AboutusModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.aboutddata.send(model)
        }).store(self)
    }
}

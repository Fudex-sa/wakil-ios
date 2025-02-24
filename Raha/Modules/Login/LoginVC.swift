//
//  LoginVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

// MARK: - ...  ViewController - Vars
class LoginVC: BaseController {
  
    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
    let appleDriver = AppleDriver()
//    lazy var validator: Validator? = {
//        let validator = Validator(guardOnSuperViewOfTextField: true)
//        validator.setUIType(.message).append(loginTxf, rules: [GuardRequired()], title: "Mobile number or email".localized).holdColor()
//        validator.setUIType(.message).append(passwordTxf, rules: [GuardRequired() ], title: "password".localized).holdColor()
//        return validator
//    }()
}

// MARK: - ...  LifeCycle
extension LoginVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.userdata.listen(on: { [weak self] value in
           
        })
       
    }
}
// MARK: - ...  Functions
extension LoginVC {
    func setup() {
       
    }
    func loginWithApple() {
        appleDriver.closure = { [weak self] model, error in
            if error != nil {
                self?.stopLoading()
                self?.didError(error: error)
                return
            }
            self?.startLoading()
            self?.viewModel?.name.send(model?.fullName ?? "")
            self?.viewModel?.email.send(model?.email ?? "")
            self?.viewModel?.socailId.send(model?.id ?? "")
            self?.viewModel?.socialType.send(3)
            self?.viewModel?.loginsocail()
        }
        appleDriver.fetch()
    }
}
// MARK: - ...  View Contract
extension LoginVC {
}

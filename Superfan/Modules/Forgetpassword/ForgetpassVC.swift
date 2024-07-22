//
//  ForgetpassVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ForgetpassVC: BaseController {
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var forgetBtn: UIButton!
    var viewModel: ForgetpassViewModel?
    var coordinator: ForgetpassCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension ForgetpassVC {
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
        
        viewModel?.resenddata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.resenddata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.coordinator?.verify()
        })
       
    }
}
// MARK: - ...  Functions
extension ForgetpassVC {
    func setup() {
        forgetBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            var phone = self?.phoneTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                if phone.count != 10 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(10)"
                }
            }else {
                if phone.count != 9 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(9)"
                }
            }
            if error == "" {
                self?.startLoading()
                var phone = self?.phoneTxf.text ?? ""
                if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                    let index = phone.index(phone.startIndex, offsetBy: 1)
                    phone = String(phone.suffix(from: index))
                    self?.viewModel?.phone.send(phone)
                }else {
                    self?.viewModel?.phone.send(self?.phoneTxf.text ?? "")
                }
                self?.viewModel?.countryCode.send("+966")
                self?.viewModel?.resendotp()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ForgetpassVC {
}

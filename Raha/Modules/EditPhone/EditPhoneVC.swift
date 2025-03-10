//
//  EditPhoneVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditPhoneVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var phoneTxf: UITextField!
    var viewModel: EditPhoneViewModel?
    var coordinator: EditPhoneCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
}

// MARK: - ...  LifeCycle
extension EditPhoneVC {
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
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
extension EditPhoneVC {
    func setup() {
        phoneTxf.text = user?.data?.mobile ?? ""
        sendBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            var phone = self?.phoneTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                if phone.count != 10 {
                    error = "\(error)\n\("mobile number".localized) \("lenght must be") 10"
                }
            }else {
                if phone.count != 9 {
                    error = "\(error)\n\("mobile number".localized) \("lenght must be") 9"
                }
            }
            if error != "" {
                self?.didError(error: error)
                return
            }
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                let index = phone.index(phone.startIndex, offsetBy: 1)
                phone = String(phone.suffix(from: index))
                self?.viewModel?.phone.send(phone)
            }else {
                self?.viewModel?.phone.send(self?.phoneTxf.text ?? "")
            }
            if self?.viewModel?.phone.value ?? "" == UD.user?.data?.user?.mobile ?? "" {
                self?.navigationController?.popViewController(animated: true)
            }
            self?.startLoading()
            self?.viewModel?.resendotp()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension EditPhoneVC {
}

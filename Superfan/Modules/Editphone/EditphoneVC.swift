//
//  EditphoneVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditphoneVC: BaseController {
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    var viewModel: EditphoneViewModel?
    var coordinator: EditphoneCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
}

// MARK: - ...  LifeCycle
extension EditphoneVC {
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
        self.tabBarController?.tabBar.isHidden = true
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
extension EditphoneVC {
    func setup() {
        changeColoe()
        phoneTxf.text = user?.data?.mobile ?? ""
        editBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            var phone = self?.phoneTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                if phone.count != (UD.user?.data?.user?.country?.mobile_length ?? 0) + 1 {
                    error = "\(error)\n\("mobile number".localized) \("lenght must be") \((UD.user?.data?.user?.country?.mobile_length ?? 0) + 1)"
                }
            }else {
                if phone.count != (UD.user?.data?.user?.country?.mobile_length ?? 0) {
                    error = "\(error)\n\("mobile number".localized) \("lenght must be") \((UD.user?.data?.user?.country?.mobile_length ?? 0))"
                }
            }
            if error != "" {
                self?.didError(error: error)
                return
            }
            self?.viewModel?.countryCode.send("+966")
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
    func changeColoe() {
        if UD.club != nil {
            editBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension EditphoneVC {
}

//
//  ResetpasswordVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ResetpasswordVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmEyeBtn: UIButton!
    @IBOutlet weak var confirmPassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    var viewModel: ResetpasswordViewModel?
    var coordinator: ResetpasswordCoordinator?
    var code = ""
    var mobile = ""
    var otp = ""
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(passwordTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Password".localized).holdColor()
        validator.setUIType(.message).append(confirmPassTxf, rules: [GuardRequired() , GuardMatch(matchWith: passwordTxf)], title: "Confirm Password".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension ResetpasswordVC {
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
        
        viewModel?.resetdata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.resetdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
        })
       
    }
}
// MARK: - ...  Functions
extension ResetpasswordVC {
    func setup() {
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.viewModel?.password.send(self?.passwordTxf.text ?? "")
            self?.viewModel?.countryCode.send(self?.code ?? "")
            self?.viewModel?.phone.send(self?.mobile ?? "")
            self?.viewModel?.otp.send(self?.otp ?? "")
            self?.startLoading()
            self?.viewModel?.resetpass()
        }).store(self)
        eyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.passwordTxf.isSecureTextEntry == true {
                self?.passwordTxf.isSecureTextEntry = false
                self?.eyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.passwordTxf.isSecureTextEntry = true
                self?.eyeBtn.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            }
        }).store(self)
        confirmEyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.confirmPassTxf.isSecureTextEntry == true {
                self?.confirmPassTxf.isSecureTextEntry = false
                self?.confirmEyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.confirmPassTxf.isSecureTextEntry = true
                self?.confirmEyeBtn.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ResetpasswordVC {
}

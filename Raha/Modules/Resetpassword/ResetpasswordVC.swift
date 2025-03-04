//
//  ResetpasswordVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ResetpasswordVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    var viewModel: ResetpasswordViewModel?
    var coordinator: ResetpasswordCoordinator?
    var mobile = ""
    var otp = ""
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(passTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Password".localized).holdColor()
        validator.setUIType(.message).append(confirmpassTxf, rules: [GuardRequired() , GuardMatch(matchWith: passTxf)], title: "Confirm Password".localized).holdColor()
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
            self?.viewModel?.password.send(self?.passTxf.text ?? "")
          //  self?.viewModel?.countryCode.send(self?.code ?? "")
            self?.viewModel?.phone.send(self?.mobile ?? "")
            self?.viewModel?.otp.send(self?.otp ?? "")
            self?.startLoading()
            self?.viewModel?.resetpass()
        }).store(self)
        eyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.passTxf.isSecureTextEntry == true {
                self?.passTxf.isSecureTextEntry = false
                self?.eyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.passTxf.isSecureTextEntry = true
                self?.eyeBtn.setImage(#imageLiteral(resourceName: "eye-slash"), for: .normal)
            }
        }).store(self)
        confirmeyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.confirmpassTxf.isSecureTextEntry == true {
                self?.confirmpassTxf.isSecureTextEntry = false
                self?.confirmeyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.confirmpassTxf.isSecureTextEntry = true
                self?.confirmeyeBtn.setImage(#imageLiteral(resourceName: "eye-slash"), for: .normal)
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ResetpasswordVC {
}

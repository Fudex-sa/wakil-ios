//
//  ResetpassVC.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ResetpassVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    @IBOutlet weak var repeatpassTxf: UITextField!
    var viewModel: ResetpassViewModel?
    var coordinator: ResetpassCoordinator?
    var mobile = ""
    var otp = ""
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(passTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "The new password".localized).holdColor()
        validator.setUIType(.message).append(repeatpassTxf, rules: [GuardRequired() , GuardMatch(matchWith: repeatpassTxf)], title: "Repeat the password".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension ResetpassVC {
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
//                NotificationBuilder()
//                    .setTitle("Success".localized)
//                    .setBody(self?.viewModel?.resetdata.value?.message ?? "")
//                    .setTheme(.success)
//                    .bulid()
            Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
        })
    }
}
// MARK: - ...  Functions
extension ResetpassVC {
    func setup() {
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.viewModel?.password.send(self?.passTxf.text ?? "")
                 //  self?.viewModel?.countryCode.send(self?.code ?? "")
            self?.viewModel?.phone.send(self?.mobile ?? "")
            self?.startLoading()
            self?.viewModel?.resetpass()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ResetpassVC {
}

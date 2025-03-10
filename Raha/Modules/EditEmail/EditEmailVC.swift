//
//  EditEmailVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditEmailVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var emailTxf: UITextField!
    var viewModel: EditEmailViewModel?
    var coordinator: EditEmailCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(emailTxf, rules: [GuardRequired() , GuardEmail()], title: "Email".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
}

// MARK: - ...  LifeCycle
extension EditEmailVC {
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
extension EditEmailVC {
    func setup() {
        emailTxf.text = user?.data?.email ?? ""
        sendBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.startLoading()
            self?.viewModel?.email.send(self?.emailTxf.text ?? "")
            self?.viewModel?.resendotp()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension EditEmailVC {
}

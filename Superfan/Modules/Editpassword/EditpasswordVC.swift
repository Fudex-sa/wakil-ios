//
//  EditpasswordVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditpasswordVC: BaseController {
    @IBOutlet weak var oldPassBtn: UIButton!
    @IBOutlet weak var oldPassTxf: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmEyeBtn: UIButton!
    @IBOutlet weak var confirmPassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    var viewModel: EditpasswordViewModel?
    var coordinator: EditpasswordCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(oldPassTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Old password".localized).holdColor()
        validator.setUIType(.message).append(passwordTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Password".localized).holdColor()
        validator.setUIType(.message).append(confirmPassTxf, rules: [GuardRequired() , GuardMatch(matchWith: passwordTxf)], title: "Confirm Password".localized).holdColor()
        
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension EditpasswordVC {
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
        
        viewModel?.editpassdata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.editpassdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            
        })
       
    }
}
// MARK: - ...  Functions
extension EditpasswordVC {
    func setup() {
       // changeColoe()
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.viewModel?.password.send(self?.passwordTxf.text ?? "")
            self?.viewModel?.oldpassword.send(self?.oldPassTxf.text ?? "")
            self?.startLoading()
            self?.viewModel?.editpass()
        }).store(self)
        oldPassBtn.publisher.listen(on: {[weak self] _ in
            if self?.oldPassTxf.isSecureTextEntry == true {
                self?.oldPassTxf.isSecureTextEntry = false
                self?.oldPassBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.oldPassTxf.isSecureTextEntry = true
                self?.oldPassBtn.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            }
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
    func changeColoe() {
        if UD.club != nil {
            saveBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension EditpasswordVC {
}

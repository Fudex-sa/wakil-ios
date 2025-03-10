//
//  EditPasswordVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditPasswordVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var neweyeBtn: UIButton!
    @IBOutlet weak var newpassTxf: UITextField!
    @IBOutlet weak var oldeyeBtn: UIButton!
    @IBOutlet weak var oldpassTxf: UITextField!
    var viewModel: EditPasswordViewModel?
    var coordinator: EditPasswordCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(oldpassTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Old password".localized).holdColor()
        validator.setUIType(.message).append(newpassTxf, rules: [GuardRequired() , GuardLength(minimumLength: 8)], title: "Password".localized).holdColor()
        validator.setUIType(.message).append(confirmpassTxf, rules: [GuardRequired() , GuardMatch(matchWith: newpassTxf)], title: "Confirm Password".localized).holdColor()
        
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension EditPasswordVC {
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
extension EditPasswordVC {
    func setup() {
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.viewModel?.password.send(self?.newpassTxf.text ?? "")
            self?.viewModel?.oldpassword.send(self?.oldpassTxf.text ?? "")
            self?.startLoading()
            self?.viewModel?.editpass()
        }).store(self)
        oldeyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.oldpassTxf.isSecureTextEntry == true {
                self?.oldpassTxf.isSecureTextEntry = false
                self?.oldeyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.oldpassTxf.isSecureTextEntry = true
                self?.oldeyeBtn.setImage(#imageLiteral(resourceName: "eye-slash"), for: .normal)
            }
        }).store(self)
        neweyeBtn.publisher.listen(on: {[weak self] _ in
            if self?.newpassTxf.isSecureTextEntry == true {
                self?.newpassTxf.isSecureTextEntry = false
                self?.neweyeBtn.setImage(#imageLiteral(resourceName: "eye Active"), for: .normal)
            } else {
                self?.newpassTxf.isSecureTextEntry = true
                self?.neweyeBtn.setImage(#imageLiteral(resourceName: "eye-slash"), for: .normal)
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
extension EditPasswordVC {
}

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
    @IBOutlet weak var regLbl: UILabel!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var langImg: UIImageView!
    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
    let googleDriver = GoogleDriver()
    let appleDriver = AppleDriver()
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired()], title: "Mobile number".localized).holdColor()
        validator.setUIType(.message).append(passTxf, rules: [GuardRequired() ], title: "Password".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension LoginVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
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
            if self?.viewModel?.userdata.value?.data != nil {
                if self?.viewModel?.userdata.value?.data?.user?.isverified ?? 0 == 1 {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                }else {
                    self?.coordinator?.verify()
                }
            }else {
                self?.coordinator?.registersocail()
            }
        })
       
    }
}
// MARK: - ...  Functions
extension LoginVC {
    func setup() {
        regLbl.UIViewAction {
            self.coordinator?.register()
        }
        forgetBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.forgetpass()
        }).store(self)
        loginBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.startLoading()
            var phone = self?.phoneTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                let index = phone.index(phone.startIndex, offsetBy: 1)
                phone = String(phone.suffix(from: index))
                self?.viewModel?.phone.send(phone)
            }else {
                self?.viewModel?.phone.send(self?.phoneTxf.text ?? "")
            }
//            self?.viewModel?.phone.send(self?.loginTxf.text ?? "")
            self?.viewModel?.password.send(self?.passTxf.text ?? "")
            self?.viewModel?.login()
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
        skipBtn.publisher.listen(on: {[weak self] _ in
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        }).store(self)
        
        langImg.UIViewAction {
            if Localizer.current == .english {
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())}
            }else {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())}
            }
        }
        googleBtn.publisherGesture.listen(on: {[weak self] _ in
           self?.loginwithgoogle()
        }).store(self)
       
        appleBtn.publisherGesture.listen { [weak self] _ in
            self?.loginWithApple()
        }.store(self)
    }
    func loginwithgoogle() {
        googleDriver.closure = { [weak self] model, error in
            if error != nil {
                self?.didError(error: error)
                return
            }
            self?.startLoading()
            self?.viewModel?.name.send(model?.fullName ?? "")
            self?.viewModel?.email.send(model?.email ?? "")
            self?.viewModel?.socailId.send(model?.id ?? "")
            self?.viewModel?.socialType.send(1)
            self?.viewModel?.loginsocail()
        }
        googleDriver.fetch(presenting: self)
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

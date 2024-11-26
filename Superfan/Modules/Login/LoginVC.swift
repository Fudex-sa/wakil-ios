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
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var regBtn: UILabel!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var loginTxf: UITextField!
    @IBOutlet weak var langView: UIView!
    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
    let appleDriver = AppleDriver()
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(loginTxf, rules: [GuardRequired()], title: "Mobile number or email".localized).holdColor()
        validator.setUIType(.message).append(passwordTxf, rules: [GuardRequired() ], title: "password".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension LoginVC {
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
        
        viewModel?.userdata.listen(on: { [weak self] value in
            if self?.viewModel?.userdata.value?.data != nil {
                if self?.viewModel?.userdata.value?.data?.user?.isverified ?? 0 == 1 {
                    if UD.user?.data?.user?.club == nil {
                        Coordinator.instance.restart(storyboard: R.storyboard.selectclubStoryboard())
                    }else {
                        UD.club = UD.user?.data?.user?.club
                        Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    }
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
        setStatusBar(color: UIColor(hex: "#181928") )
        regBtn.UIViewAction {
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
            var phone = self?.loginTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                let index = phone.index(phone.startIndex, offsetBy: 1)
                phone = String(phone.suffix(from: index))
                self?.viewModel?.phone.send(phone)
            }else {
                self?.viewModel?.phone.send(self?.loginTxf.text ?? "")
            }
//            self?.viewModel?.phone.send(self?.loginTxf.text ?? "")
            self?.viewModel?.countryCode.send("+966")
            self?.viewModel?.password.send(self?.passwordTxf.text ?? "")
            self?.viewModel?.login()
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
        skipBtn.publisher.listen(on: {[weak self] _ in
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        }).store(self)
        langView.publisherGesture.listen(on: {[weak self] _ in
            if self?.langLbl.text == "AR".localized {
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())}
            }else {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())}
            }
            
        }).store(self)
        
        googleView.publisherGesture.listen(on: {[weak self] _ in
            let signInConfig = GIDConfiguration.init(clientID: SocialConstant.googleId)
                       GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self!) { user, error in
                           if ((user?.userID != nil)) {
                               self?.startLoading()
                               self?.viewModel?.name.send(user?.profile?.name ?? "")
                               self?.viewModel?.email.send(user?.profile?.email ?? "")
                               self?.viewModel?.socailId.send(user?.userID ?? "")
                               self?.viewModel?.socialType.send(1)
                               self?.viewModel?.loginsocail()
                           }
                       }
        }).store(self)
       
        appleView.publisherGesture.listen { [weak self] _ in
            self?.loginWithApple()
        }.store(self)
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

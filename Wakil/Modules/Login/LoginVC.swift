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
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetStack: UIStackView!
    @IBOutlet weak var passTxf: UITextField!
    @IBOutlet weak var phoneTxf: UITextField!
    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
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
            if UD.type == 1 {
                Coordinator.instance.restart(storyboard: R.storyboard.mainuserStoryboard())
            }else  if UD.type == 2 {
                Coordinator.instance.restart(storyboard: R.storyboard.providermainStoryboard())
            }
//            if self?.viewModel?.userdata.value?.data != nil {
//
////                if self?.viewModel?.userdata.value?.data?.user?.isverified ?? 0 == 1 {
////                  //  Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
////                }else {
////                    if self?.viewModel?.userdata.value?.data?.user?.isSocial ?? 1 == 0 {
////                        self?.coordinator?.verify()
////                    }else {
////                        //Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
////                    }
////                }
//            }else {
//                self?.coordinator?.registersocail()
//            }
        })
       
    }
}
// MARK: - ...  Functions
extension LoginVC {
    func setup() {
        regLbl.underline()
        regLbl.UIViewAction {
            self.coordinator?.register()
        }
        forgetStack.UIViewAction {
            self.coordinator?.forgetpass()
        }
        forgetStack.publisherGesture.listen(on: {[weak self] _ in
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
        
//        skipBtn.publisher.listen(on: {[weak self] _ in
//            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
//        }).store(self)
        
    
    }
   
}
// MARK: - ...  View Contract
extension LoginVC {
}

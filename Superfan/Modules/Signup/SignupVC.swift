//
//  SignupVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SignupVC: BaseController {
    @IBOutlet weak var passspaceView: UIView!
    @IBOutlet weak var confirmpassView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var checkBtn: CheckBoxButton!
    @IBOutlet weak var confirmEyeBtn: UIButton!
    @IBOutlet weak var confirmPassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var mapLbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var userTxf: UITextField!
    var viewModel: SignupViewModel?
    var coordinator: SignupCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "mobile number".localized).holdColor()
        validator.setUIType(.message).append(userTxf, rules: [GuardRequired() ], title: "Username".localized).holdColor()
        validator.setUIType(.message).append(emailTxf, rules: [GuardRequired() , GuardEmail() ], title: "Email".localized).holdColor()
        return validator
    }()
    lazy var validator1: Validator? = {
        let validator1 = Validator(guardOnSuperViewOfTextField: true)
        validator1.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "mobile number".localized).holdColor()
        validator1.setUIType(.message).append(userTxf, rules: [GuardRequired() ], title: "Full Name".localized).holdColor()
        validator1.setUIType(.message).append(emailTxf, rules: [GuardRequired() , GuardEmail() ], title: "Email".localized).holdColor()
        validator1.setUIType(.message).append(passwordTxf, rules: [GuardRequired() , GuardLength(minimumLength: 6)], title: "password".localized).holdColor()
        validator1.setUIType(.message).append(confirmPassTxf, rules: [GuardRequired() , GuardMatch(matchWith: passwordTxf)], title: "Confirm Password".localized).holdColor()
        return validator1
    }()
    var registertype = 0
    var email = ""
    var type = 0
    var name = ""
    var socailId = ""
}

// MARK: - ...  LifeCycle
extension SignupVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
        if type != 0 {
            emailTxf.text = email
            userTxf.text = name
            if email != "" {
                emailTxf.isEnabled = false
            }
            passwordView.isHidden = true
            confirmpassView.isHidden = true
            passspaceView.isHidden = true
            viewModel?.socailId.send(socailId ?? "")
            viewModel?.socailType.send(type ?? 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator = .init()
        coordinator?.view = self
        bind()
        actions()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel?.userdata = .init()

    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.items.listen(on: { [weak self] value in
            self?.stopLoading()
        })
        viewModel?.userdata.listen(on: { [weak self] value in
            self?.coordinator?.verify()
        })
    }
}
// MARK: - ...  Functions
extension SignupVC {
    func setup() {
        startLoading()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.countryId.send(1)
        viewModel?.fetchstates()
    }
    func actions(){
        termsLbl.UIViewAction {
            self.coordinator?.terms()
        }
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
        cityView.publisherGesture.listen(on: {[weak self] _ in
            self?.pickstates()
        }).store(self)
        regBtn.publisher.listen(on: {[weak self] _ in
            if self?.registertype ?? 0 == 1 {
                if self?.validator1?.build() == false {
                    return
                }
            }else {
                if self?.validator?.build() == false {
                    return
                }
            }
            var error = ""
            if self?.viewModel?.stateId.value ?? 0 == 0 {
                error = "select city".localized
            }
            if self?.checkBtn.isOn == false {
                error = "\(error)\n\("agree to".localized) \("terms and conditions".localized)"
            }
            var phone = self?.phoneTxf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                if phone.count != 10 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(10)"
                }
            }else {
                if phone.count != 9 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(9)"
                }
            }
            if error == "" {
                if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                    let index = phone.index(phone.startIndex, offsetBy: 1)
                    phone = String(phone.suffix(from: index))
                    self?.viewModel?.phone.send(phone)
                }else {
                    self?.viewModel?.phone.send(self?.phoneTxf.text ?? "")
                }
                self?.viewModel?.name.send(self?.userTxf.text ?? "")
                self?.viewModel?.email.send(self?.emailTxf.text ?? "")
                self?.viewModel?.password.send(self?.passwordTxf.text ?? "")
                self?.viewModel?.lat.send("29.66464")
                self?.viewModel?.lng.send("31.74646")
                self?.viewModel?.countryCode.send("+966")
                self?.startLoading()
                self?.viewModel?.checkregister()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
   
    func pickstates() {
        let scene = SearchViewPicker(nib: R.nib.searchViewPicker)
        scene.pickTitle.send("City".localized)
        scene.source = viewModel?.items.value ?? []
        scene.didSelectItem.listen(on: { [weak self] didSelect in
            guard let item = didSelect?.1 as? RegisterModel else { return }
            self?.cityLbl.text = item.name ?? ""
            self?.cityLbl.textColor = R.color.black()
            self?.viewModel?.stateId.send(item.id ?? 0)
        })
        self.pushPop(scene)
    }
}
// MARK: - ...  View Contract
extension SignupVC {
}

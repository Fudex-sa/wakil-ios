//
//  RegisterVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class RegisterVC: BaseController {
    @IBOutlet weak var confirmSpace1View: UIView!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmSpaceView: UIView!
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var passSpace1View: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passSpaceView: UIView!
    @IBOutlet weak var passLbl: UILabel!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var CheckBtn: CheckBoxButton!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var nameTxf: UITextField!
    var viewModel: RegisterViewModel?
    var coordinator: RegisterCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        validator.setUIType(.message).append(nameTxf, rules: [GuardRequired() ], title: "Name".localized).holdColor()
        return validator
    }()
    lazy var validator1: Validator? = {
        let validator1 = Validator(guardOnSuperViewOfTextField: true)
        validator1.setUIType(.message).append(phoneTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        validator1.setUIType(.message).append(nameTxf, rules: [GuardRequired() ], title: "Name".localized).holdColor()
        validator1.setUIType(.message).append(passTxf, rules: [GuardRequired() , GuardLength(minimumLength: 6)], title: "Password".localized).holdColor()
        validator1.setUIType(.message).append(confirmpassTxf, rules: [GuardRequired() , GuardMatch(matchWith: passTxf)], title: "Confirm Password".localized).holdColor()
        return validator1
    }()
    var registertype = 0
    var email = ""
    var type = 0
    var name = ""
    var socailId = ""
}

// MARK: - ...  LifeCycle
extension RegisterVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
        if type != 0 {
            nameTxf.text = name
            passView.isHidden = true
            confirmView.isHidden = true
            passLbl.isHidden = true
            confirmLbl.isHidden = true
            passSpaceView.isHidden = true
            passSpace1View.isHidden = true
            confirmSpaceView.isHidden = true
            confirmSpace1View.isHidden = true
            viewModel?.socailId.send(socailId ?? "")
            viewModel?.socailType.send(type ?? 0)
            viewModel?.email.send(email ?? "")
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
        viewModel = nil
        coordinator = nil
        viewModel?.userdata = .init()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.userdata.listen(on: { [weak self] value in
            self?.coordinator?.verify()
        })
    }
}
// MARK: - ...  Functions
extension RegisterVC {
    func setup() {
    }
    func actions(){
        termsLbl.UIViewAction {
            self.coordinator?.terms()
        }
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
       
        regBtn.publisher.listen(on: {[weak self] _ in
            if self?.type ?? 0 == 0 {
                if self?.validator1?.build() == false {
                    return
                }
            }else {
                if self?.validator?.build() == false {
                    return
                }
            }
            var error = ""
//            if self?.viewModel?.stateId.value ?? 0 == 0 {
//                error = "select city".localized
//            }
            if self?.CheckBtn.isOn == false {
                error = "\(error)\n\("agree to".localized) \("Terms & Conditions".localized)"
            }
//            if self?.photoURL == nil {
//                error = "\(error)\n\("add personal image".localized)"
//            }
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
               
                self?.viewModel?.name.send(self?.nameTxf.text ?? "")
                self?.viewModel?.password.send(self?.passTxf.text ?? "")
                self?.startLoading()
                self?.viewModel?.checkregister()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
   
    
}
// MARK: - ...  View Contract
extension RegisterVC {
}

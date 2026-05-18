//
//  VerifyVC.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class VerifyVC: BaseController {
    enum VerifyType {
        case register
        case forget
        case update
        case updateemail
    }
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var num1Txf: UITextField!
    @IBOutlet weak var num2Txf: UITextField!
    @IBOutlet weak var num3Txf: UITextField!
    @IBOutlet weak var num4Txf: UITextField!
    @IBOutlet weak var resendView: UIView!
    var viewModel: VerifyViewModel?
    var coordinator: VerifyCoordinator?
    var verifyCodeInputs: VerifyCodeInputs?
    //var delegate: VerifycodeVCCDelegate?
    var timer: TimeHelper?
    var type: VerifyType = .register
    var code = ""
    var mobile = ""
    var time = 120
    var isorder = 0
}

// MARK: - ...  LifeCycle
extension VerifyVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: num4Txf)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: num1Txf)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
        viewModel?.checkotp = .init()
    }
    override func bind() {
           super.bind()
           viewModel?.error.listen(on: { [weak self] error in
               self?.stopLoading()
               self?.didError(error: error?.localizedDescription)
           })
           
           viewModel?.userdata.listen(on: { [weak self] value in
//               NotificationBuilder()
//                   .setTitle("Success".localized)
//                   .setBody(self?.viewModel?.userdata.value?.message ?? "")
//                   .setTheme(.success)
//                   .bulid()
               if self?.type == .forget {
                   self?.coordinator?.resetpass()
               }else if self?.type == .register {
                   Coordinator.instance.restart(storyboard: R.storyboard.selecttypeStoryboard())
               }
           })
           viewModel?.resenddata.listen(on: { [weak self] value in
               self?.stopLoading()
//               NotificationBuilder()
//                   .setTitle("Success".localized)
//                   .setBody(self?.viewModel?.resenddata.value?.message ?? "")
//                   .setTheme(.success)
//                   .bulid()
           })
//           viewModel?.editphonedata.listen(on: { [weak self] value in
//               NotificationBuilder()
//                   .setTitle("Success".localized)
//                   .setBody(self?.viewModel?.editphonedata.value?.message ?? "")
//                   .setTheme(.success)
//                   .bulid()
//               if self?.isorder ?? 0 == 1 {
//                   self?.delegate?.done()
//                   self?.navigationController?.popViewController(animated: true)
//               }else {
//                   Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
//               }
//           })
           viewModel?.checkotp.listen(on: { [weak self] value in
               self?.coordinator?.resetpass()
           })
       }
}
// MARK: - ...  Functions
extension VerifyVC {
    func setup() {
        resendLbl.underline()
           verifyCodeInputs = .init()
           verifyCodeInputs?.dataSource = self
           verifyCodeInputs?.reset()
           if type == .forget {
               viewModel?.countryCode.send(code)
               viewModel?.phone.send(mobile)
               viewModel?.type.send("password_reset")
           }else if type == .update {
               viewModel?.countryCode.send(code)
               viewModel?.phone.send(mobile)
           }else if type == .updateemail {
               viewModel?.phone.send(mobile)
           }else {
              // backBtn.isHidden = true
               viewModel?.countryCode.send(UD.user?.data?.user?.country?.code ?? "")
               viewModel?.phone.send(UD.user?.data?.user?.mobile ?? "")
               viewModel?.type.send("register")
           }
       }
       func actions() {
           resendView.publisherGesture.listen(on: {[weak self] _ in
               self?.startLoading()
               if self?.type == .update {
                   self?.viewModel?.resendphoneotp()
               }else  if self?.type == .updateemail {
                   self?.viewModel?.resendemaileotp()
               }else  if self?.type == .forget {
                   self?.viewModel?.resendotpforget()
               }else {
                   self?.viewModel?.resendotp()
               }
           }).store(self)
           verifyBtn.publisher.listen(on: {[weak self] _ in
               let code = self?.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
               if self?.type == .forget {
                   self?.startLoading()
                   self?.viewModel?.otp.send(code ?? "")
                   self?.viewModel?.confirmotp()
               }else if self?.type == .update {
                   self?.startLoading()
                   self?.viewModel?.otp.send(code ?? "")
                   self?.viewModel?.editphone()
               }else if self?.type == .updateemail {
                   self?.startLoading()
                   self?.viewModel?.otp.send(code ?? "")
                   self?.viewModel?.editemail()
               }else {
                   self?.startLoading()
                   self?.viewModel?.otp.send(code ?? "")
                   self?.viewModel?.confirmotp()
               }
           }).store(self)

       }
       @objc func textFieldTextDidChange(_ notification: Notification) {
           // The text in the text field has changed
           if let textField = notification.object as? UITextField {
               print("Text field value changed: \(textField.text ?? "")")
               if Localizer.current == .english {
                   if self.num4Txf.text?.count ?? 0 > 0 {
                       let code = self.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
                       if code?.isEmpty == true || code == nil || code?.count ?? 0 != 4{
                           verifyBtn.isHidden = true
                           return
                       }
                       verifyBtn.isHidden = false
                      
                   }
               }else {
                   if self.num1Txf.text?.count ?? 0 > 0 {
                       let code = self.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
                       if code?.isEmpty == true || code == nil || code?.count ?? 0 != 4{
                           verifyBtn.isHidden = true
                           return
                       }
                       verifyBtn.isHidden = false

                   }
               }
           }
       }
}
// MARK: - ...  View Contract
extension VerifyVC {
}
extension VerifyVC: VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView? {
        return self.view
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField] {
        return [num1Txf, num2Txf, num3Txf, num4Txf]
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyTextColor: Bool?) -> UIColor {
        return R.color.whiteColor()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillTextColor: Bool?) -> UIColor {
        return R.color.whiteColor()!

    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBackground: Bool?) -> UIColor {
        return UIColor(hex: "#095F5B57")
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillBackground: Bool?) -> UIColor {
        return UIColor(hex: "#095F5B57")

    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor {
        return R.color.whiteColor()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return R.color.whiteColor()!


    }
}

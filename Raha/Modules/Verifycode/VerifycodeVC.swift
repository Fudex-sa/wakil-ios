//
//  VerifycodeVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol VerifycodeVCCDelegate: AnyObject {
    func done()

}
// MARK: - ...  ViewController - Vars
class VerifycodeVC: BaseController {
    enum VerifyType {
        case register
        case forget
        case update
        case updateemail
    }
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var verfiy4Txf: UITextField!
    @IBOutlet weak var verfiy3Txf: UITextField!
    @IBOutlet weak var verfiy2Txf: UITextField!
    @IBOutlet weak var verfiy1Txf: UITextField!
    @IBOutlet weak var phoneLbl: UILabel!
    var viewModel: VerifycodeViewModel?
    var coordinator: VerifycodeCoordinator?
    var verifyCodeInputs: VerifyCodeInputs?
    var delegate: VerifycodeVCCDelegate?
    var timer: TimeHelper?
    var type: VerifyType = .register
    var code = ""
    var mobile = ""
    var time = 120
    var isorder = 0
}

// MARK: - ...  LifeCycle
extension VerifycodeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: verfiy4Txf)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: verfiy1Txf)
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
        viewModel = nil
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
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.userdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        })
        viewModel?.resenddata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.time = 120
            self?.setupTimer()
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.resenddata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
        })
        viewModel?.editphonedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.editphonedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            if self?.isorder ?? 0 == 1 {
                self?.delegate?.done()
                self?.navigationController?.popViewController(animated: true)
            }else {
                Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
            }
        })
        viewModel?.checkotp.listen(on: { [weak self] value in
            self?.coordinator?.resetpass()
        })
    }
}
// MARK: - ...  Functions
extension VerifycodeVC {
    func setup() {
        setupTimer()
        verifyCodeInputs = .init()
        verifyCodeInputs?.dataSource = self
        verifyCodeInputs?.reset()
        if type == .forget {
            phoneLbl.text = "\(code)\(mobile)"
            viewModel?.countryCode.send(code)
            viewModel?.phone.send(mobile)
            viewModel?.type.send("password_reset")
        }else if type == .update {
            phoneLbl.text = "\(code)\(mobile)"
            viewModel?.countryCode.send(code)
            viewModel?.phone.send(mobile)
        }else if type == .updateemail {
            phoneLbl.text = "\(mobile)"
            viewModel?.phone.send(mobile)
        }else {
           // backBtn.isHidden = true
            phoneLbl.text = "\(UD.user?.data?.user?.country?.code ?? "")\(UD.user?.data?.user?.mobile ?? "")"
            viewModel?.countryCode.send(UD.user?.data?.user?.country?.code ?? "")
            viewModel?.phone.send(UD.user?.data?.user?.mobile ?? "")
            viewModel?.type.send("register")
        }
    }
    func actions() {
        resendBtn.publisher.listen(on: {[weak self] _ in
            self?.startLoading()
            if self?.type == .update {
                self?.viewModel?.resendphoneotp()
            }else  if self?.type == .updateemail {
                self?.viewModel?.resendemaileotp()
            }else {
                self?.viewModel?.resendotp()
            }
        }).store(self)
        verifyBtn.publisher.listen(on: {[weak self] _ in
            let code = self?.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
            if self?.type == .forget {
                self?.startLoading()
                self?.viewModel?.otp.send(code ?? "")
                self?.viewModel?.checkotprequest()
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
    func setupTimer() {
            resendBtn.isUserInteractionEnabled = false
            resendBtn.backgroundColor = R.color.gray()
            timer = .init(seconds: 1, numberOfCycle: time, closure: { [weak self] second in
                if second == 0 {
                    self?.resendBtn.isUserInteractionEnabled = true
                    self?.resendBtn.backgroundColor = R.color.normalblue()
                    self?.timer?.stopTimer()
                    self?.timer = nil
                }
                self?.timeLbl.text = "\(second.fromatSecondsFromTimer())"
            })
        }
    @objc func textFieldTextDidChange(_ notification: Notification) {
        // The text in the text field has changed
        if let textField = notification.object as? UITextField {
            print("Text field value changed: \(textField.text ?? "")")
            if Localizer.current == .english {
                if self.verfiy4Txf.text?.count ?? 0 > 0 {
                    let code = self.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
                    if code?.isEmpty == true || code == nil || code?.count ?? 0 != 4{
                        verifyBtn.isHidden = true
                        return
                    }
                    verifyBtn.isHidden = false
                   
                }
            }else {
                if self.verfiy1Txf.text?.count ?? 0 > 0 {
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
extension VerifycodeVC {
}
extension VerifycodeVC: VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView? {
        return self.view
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField] {
        return [verfiy1Txf, verfiy2Txf, verfiy3Txf, verfiy4Txf]
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyTextColor: Bool?) -> UIColor {
        return R.color.black()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillTextColor: Bool?) -> UIColor {
        return R.color.normalblue()!

    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBackground: Bool?) -> UIColor {
        return UIColor(hex: "#F7F7F8")
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillBackground: Bool?) -> UIColor {
        return R.color.lightblue()!
        
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor {
        return R.color.lightgray()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return R.color.normalblue()!


    }
}

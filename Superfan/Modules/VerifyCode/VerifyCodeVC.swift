//
//  VerifyCodeVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class VerifyCodeVC: BaseController {
    enum VerifyType {
        case register
        case forget
        case update
    }
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var verfiy4Txf: UITextField!
    @IBOutlet weak var verfiy3Txf: UITextField!
    @IBOutlet weak var verfiy2Txf: UITextField!
    @IBOutlet weak var verfiy1Txf: UITextField!
    @IBOutlet weak var phoneLbl: UILabel!
    var viewModel: VerifyCodeViewModel?
    var coordinator: VerifyCodeCoordinator?
    var verifyCodeInputs: VerifyCodeInputs?
    var timer: TimeHelper?
    var type: VerifyType = .register
    var code = ""
    var mobile = ""
}

// MARK: - ...  LifeCycle
extension VerifyCodeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: verfiy4Txf)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: verfiy1Txf)
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
            Coordinator.instance.restart(storyboard: R.storyboard.selectclubStoryboard())
        })
        viewModel?.checkotp.listen(on: { [weak self] value in
            self?.coordinator?.resetpass()
        })
    }
}
// MARK: - ...  Functions
extension VerifyCodeVC {
    func setup() {
        setupTimer()
        verifyCodeInputs = .init()
        verifyCodeInputs?.dataSource = self
        verifyCodeInputs?.reset()
        if type == .forget {
            phoneLbl.text = "\(code)\(mobile)"
            viewModel?.countryCode.send(code)
            viewModel?.phone.send(mobile)
        }else if type == .update {
            phoneLbl.text = "\(code)\(mobile)"
            viewModel?.countryCode.send(code)
            viewModel?.phone.send(mobile)
        }else {
            phoneLbl.text = "\(UD.user?.data?.user?.country?.code ?? "")\(UD.user?.data?.user?.mobile ?? "")"
            viewModel?.countryCode.send(UD.user?.data?.user?.country?.code ?? "")
            viewModel?.phone.send(UD.user?.data?.user?.mobile ?? "")
        }
    }
    func actions() {
        resendBtn.publisher.listen(on: {[weak self] _ in
            self?.startLoading()
            if self?.type == .update {
                self?.viewModel?.resendphoneotp()
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
            }else {
                self?.startLoading()
                self?.viewModel?.otp.send(code ?? "")
                self?.viewModel?.confirmotp()
            }
        }).store(self)

    }
    func setupTimer() {
            resendBtn.isUserInteractionEnabled = false
            resendBtn.setTitleColor(R.color.txtprimary(), for: .normal)
            timer = .init(seconds: 1, numberOfCycle: 180, closure: { [weak self] second in
                if second == 0 {
                    self?.resendBtn.isUserInteractionEnabled = true
                    self?.resendBtn.setTitleColor(R.color.primary(), for: .normal)
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
extension VerifyCodeVC {
}
extension VerifyCodeVC: VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView? {
        return self.view
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField] {
        return [verfiy1Txf, verfiy2Txf, verfiy3Txf, verfiy4Txf]
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyTextColor: Bool?) -> UIColor {
        return R.color.black1()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillTextColor: Bool?) -> UIColor {
        return R.color.primary()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBackground: Bool?) -> UIColor {
        return R.color.bordergray()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillBackground: Bool?) -> UIColor {
        return R.color.txtprimary()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor {
        return R.color.bordergray()!
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return R.color.primary()!
    }
}

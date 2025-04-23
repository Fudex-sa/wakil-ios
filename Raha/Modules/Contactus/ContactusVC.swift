//
//  ContactusVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ContactusVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextView!
    @IBOutlet weak var emailTxf: UITextField!
    var viewModel: ContactusViewModel?
    var coordinator: ContactusCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(emailTxf, rules: [GuardRequired() , GuardEmail()], title: "Email".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension ContactusVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        if UD.user != nil {
            emailTxf.text = UD.user?.data?.user?.email ?? ""
        }
        messageTxt.text =  "Message text".localized
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
        
        viewModel?.contact.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle(self?.viewModel?.contact.value?.message ?? "")
                .setBody("Thank you for contacting us, we will preview the message and reply to you as soon as possible".localized)
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
        })
       
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
// MARK: - ...  Functions
extension ContactusVC {
    func setup() {
        messageTxt.delegate = self
        messageTxt.textColor = R.color.black3()
        sendBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            if self?.messageTxt.text == self?.messageTxt.localization || self?.messageTxt.text == "" {
                error = "write message".localized
            }
           
            if error == "" {
                self?.viewModel?.email.send(self?.emailTxf.text ?? "")
                self?.viewModel?.message.send(self?.messageTxt.text ?? "")
                self?.startLoading()
                self?.viewModel?.sendMessage()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ContactusVC {
}
extension ContactusVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if messageTxt.textColor == R.color.black3() {
                messageTxt.text = nil
                messageTxt.textColor = R.color.black1()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if messageTxt.text.isEmpty {
                messageTxt.textColor = R.color.black3() // YOUR PREFERED PLACEHOLDER COLOR HERE
                messageTxt.text =  "Message text".localized
            }
        }
           
}

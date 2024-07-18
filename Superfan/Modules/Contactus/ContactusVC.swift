//
//  ContactusVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ContactusVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextView!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var contactImg: UIImageView!
    var viewModel: ContactusViewModel?
    var coordinator: ContactusCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(mobileTxf, rules: [GuardRequired() , GuardNumeric()], title: "Mobile number".localized).holdColor()
        validator.setUIType(.message).append(nameTxf, rules: [GuardRequired() ], title: "Full Name".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension ContactusVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        if UD.user != nil {
            mobileTxf.text = UD.user?.data?.user?.mobile ?? ""
            nameTxf.text = UD.user?.data?.user?.name ?? ""
        }
        messageTxt.text =  "Write what you think ..".localized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = true
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
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.contact.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
        })
       
    }
}
// MARK: - ...  Functions
extension ContactusVC {
    func setup() {
        changeColoe()
        do {
            loaderGIF = try UIImage(gifName: "contact.gif")
            contactImg?.setGifImage(loaderGIF)
        } catch {
            print(error.localizedDescription)
        }
        messageTxt.delegate = self
        messageTxt.textColor = R.color.gray1()
        sendBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            if self?.messageTxt.text == self?.messageTxt.localization || self?.messageTxt.text == "" {
                error = "write message".localized
            }
           
            if error == "" {
                self?.viewModel?.phone.send(self?.mobileTxf.text ?? "")
                self?.viewModel?.name.send(self?.nameTxf.text ?? "")
                self?.viewModel?.message.send(self?.messageTxt.text ?? "")
                self?.startLoading()
                self?.viewModel?.sendMessage()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            sendBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension ContactusVC {
}
extension ContactusVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if messageTxt.textColor == R.color.gray1() {
                messageTxt.text = nil
                messageTxt.textColor = R.color.black()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if messageTxt.text.isEmpty {
                messageTxt.textColor = R.color.gray1() // YOUR PREFERED PLACEHOLDER COLOR HERE
                messageTxt.text =  "Write what you think ..".localized
            }
        }
           
}

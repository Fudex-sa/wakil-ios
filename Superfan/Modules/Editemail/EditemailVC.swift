//
//  EditemailVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditemailVC: BaseController {
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    var viewModel: EditemailViewModel?
    var coordinator: EditemailCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(emailTxf, rules: [GuardRequired() , GuardEmail()], title: "Email".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
}

// MARK: - ...  LifeCycle
extension EditemailVC {
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
        
        viewModel?.editemaildata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.editemaildata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
        })
       
    }
}
// MARK: - ...  Functions
extension EditemailVC {
    func setup() {
        emailTxf.text = user?.data?.email ?? ""
        editBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            self?.startLoading()
            self?.viewModel?.email.send(self?.emailTxf.text ?? "")
            self?.viewModel?.editemail()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension EditemailVC {
}

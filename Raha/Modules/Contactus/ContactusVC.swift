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
}

// MARK: - ...  LifeCycle
extension ContactusVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ContactusVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ContactusVC {
}

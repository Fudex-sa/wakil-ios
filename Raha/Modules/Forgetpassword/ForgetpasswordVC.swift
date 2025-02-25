//
//  ForgetpasswordVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ForgetpasswordVC: BaseController {
    var viewModel: ForgetpasswordViewModel?
    var coordinator: ForgetpasswordCoordinator?
}

// MARK: - ...  LifeCycle
extension ForgetpasswordVC {
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
extension ForgetpasswordVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ForgetpasswordVC {
}

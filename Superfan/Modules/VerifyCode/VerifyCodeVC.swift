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
    var viewModel: VerifyCodeViewModel?
    var coordinator: VerifyCodeCoordinator?
}

// MARK: - ...  LifeCycle
extension VerifyCodeVC {
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
extension VerifyCodeVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension VerifyCodeVC {
}

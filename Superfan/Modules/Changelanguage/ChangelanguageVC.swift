//
//  ChangelanguageVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ChangelanguageVC: BaseController {
    var viewModel: ChangelanguageViewModel?
    var coordinator: ChangelanguageCoordinator?
}

// MARK: - ...  LifeCycle
extension ChangelanguageVC {
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
extension ChangelanguageVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ChangelanguageVC {
}

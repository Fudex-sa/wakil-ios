//
//  ProviderregisterVC.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProviderregisterVC: BaseController {
    var viewModel: ProviderregisterViewModel?
    var coordinator: ProviderregisterCoordinator?
}

// MARK: - ...  LifeCycle
extension ProviderregisterVC {
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
extension ProviderregisterVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ProviderregisterVC {
}

//
//  ChooseLocMethodVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ChooseLocMethodVC: BaseController {
    var viewModel: ChooseLocMethodViewModel?
    var coordinator: ChooseLocMethodCoordinator?
}

// MARK: - ...  LifeCycle
extension ChooseLocMethodVC {
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
extension ChooseLocMethodVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ChooseLocMethodVC {
}

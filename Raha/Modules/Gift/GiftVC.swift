//
//  GiftVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class GiftVC: BaseController {
    var viewModel: GiftViewModel?
    var coordinator: GiftCoordinator?
}

// MARK: - ...  LifeCycle
extension GiftVC {
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
extension GiftVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension GiftVC {
}

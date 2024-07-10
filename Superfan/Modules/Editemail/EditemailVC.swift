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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension EditemailVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension EditemailVC {
}

//
//  FaqVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FaqVC: BaseController {
    @IBOutlet weak var faqTbl: UITableView!
    var viewModel: FaqViewModel?
    var coordinator: FaqCoordinator?
}

// MARK: - ...  LifeCycle
extension FaqVC {
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
extension FaqVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension FaqVC {
}

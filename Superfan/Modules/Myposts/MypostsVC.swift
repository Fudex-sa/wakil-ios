//
//  MypostsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MypostsVC: BaseController {
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    var viewModel: MypostsViewModel?
    var coordinator: MypostsCoordinator?
}

// MARK: - ...  LifeCycle
extension MypostsVC {
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
extension MypostsVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension MypostsVC {
}

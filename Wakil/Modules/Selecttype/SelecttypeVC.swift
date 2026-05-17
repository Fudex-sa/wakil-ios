//
//  SelecttypeVC.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SelecttypeVC: BaseController {
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var providerBtn: UIButton!
    var viewModel: SelecttypeViewModel?
    var coordinator: SelecttypeCoordinator?
}

// MARK: - ...  LifeCycle
extension SelecttypeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension SelecttypeVC {
    func setup() {
        userBtn.publisher.listen(on: {[weak self] _ in
            UD.type = 1
            self?.coordinator?.login()
        }).store(self)
        providerBtn.publisher.listen(on: {[weak self] _ in
            UD.type = 2
            self?.coordinator?.login()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension SelecttypeVC {
}

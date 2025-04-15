//
//  ChooseLocMethodVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol ChooseLocMethodVCDelegate: AnyObject {
    func addaddressreturn()
    func currentlocreturn()
}
// MARK: - ...  ViewController - Vars
class ChooseLocMethodVC: BaseController {
    @IBOutlet weak var locBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    var viewModel: ChooseLocMethodViewModel?
    var coordinator: ChooseLocMethodCoordinator?
    var delegate: ChooseLocMethodVCDelegate?
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
        setup()
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
        addBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.addaddressreturn()
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        locBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.currentlocreturn()
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ChooseLocMethodVC {
}

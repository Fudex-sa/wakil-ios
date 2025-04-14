//
//  CancelOrderVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CancelOrderVC: BaseController {
    @IBOutlet weak var cancelLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    var viewModel: CancelOrderViewModel?
    var coordinator: CancelOrderCoordinator?
    var centerId = 0
}

// MARK: - ...  LifeCycle
extension CancelOrderVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.policyddata.listen(on: { [weak self] value in
            self?.cancelLbl.text = self?.viewModel?.policyddata.value?.data?.description?.htmlToString ?? ""
        })
        
    }
}
// MARK: - ...  Functions
extension CancelOrderVC {
    func setup() {
        viewModel?.getcancelpolicy()
    }
}
// MARK: - ...  View Contract
extension CancelOrderVC {
}

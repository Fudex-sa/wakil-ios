//
//  PaymentDoneVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class PaymentDoneVC: BaseController {
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var bookBtn: UIButton!
    var viewModel: PaymentDoneViewModel?
    var coordinator: PaymentDoneCoordinator?
}

// MARK: - ...  LifeCycle
extension PaymentDoneVC {
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
extension PaymentDoneVC {
    func setup() {
        homeBtn.publisher.listen(on: {[weak self] _ in
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        }).store(self)
        
        bookBtn.publisher.listen(on: {[weak self] _ in
            Constants.index = 1
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension PaymentDoneVC {
}

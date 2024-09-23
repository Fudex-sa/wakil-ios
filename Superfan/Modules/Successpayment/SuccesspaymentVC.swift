//
//  SuccesspaymentVC.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SuccesspaymentVC: BaseController {
    @IBOutlet weak var doneBtn: UIButton!
    var viewModel: SuccesspaymentViewModel?
    var coordinator: SuccesspaymentCoordinator?
}

// MARK: - ...  LifeCycle
extension SuccesspaymentVC {
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
extension SuccesspaymentVC {
    func setup() {
        doneBtn.publisher.listen(on: {[weak self] _ in
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        if UD.club != nil {
            doneBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension SuccesspaymentVC {
}

//
//  ForceUpdateVC.swift
//  Superfan
//
//  Created by ADAM on 14/10/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ForceUpdateVC: BaseController {
    @IBOutlet weak var storeBtn: UIButton!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    var msg = ""
    var viewModel: ForceUpdateViewModel?
    var coordinator: ForceUpdateCoordinator?
}

// MARK: - ...  LifeCycle
extension ForceUpdateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ForceUpdateVC {
    func setup() {
        if msg != "" {
            msgLbl.text = msg ?? ""
            storeBtn.isHidden = false
            contentLbl.text = ""
        }
        storeBtn.UIViewAction{
            Common().openUrl(text: "https://apps.apple.com/app/superfans/id6547850254")
        }
    }
}
// MARK: - ...  View Contract
extension ForceUpdateVC {
}

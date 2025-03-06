//
//  AboutusVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AboutusVC: BaseController {
    @IBOutlet weak var desLbl: UILabel!
    var viewModel: AboutusViewModel?
    var coordinator: AboutusCoordinator?
}

// MARK: - ...  LifeCycle
extension AboutusVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
        
        viewModel?.aboutddata.listen(on: { [weak self] value in
            self?.desLbl.text = self?.viewModel?.aboutddata.value?.data?.description?.htmlToString ?? ""
        })
        
    }
}
// MARK: - ...  Functions
extension AboutusVC {
    func setup() {
        viewModel?.getabout()
    }
}
// MARK: - ...  View Contract
extension AboutusVC {
}

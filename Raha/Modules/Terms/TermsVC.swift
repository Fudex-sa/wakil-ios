//
//  TermsVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class TermsVC: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    var viewModel: TermsViewModel?
    var coordinator: TermsCoordinator?
    var isprivacy = false
}

// MARK: - ...  LifeCycle
extension TermsVC {
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
            self?.desLbl.attributedText = self?.viewModel?.aboutddata.value?.data?.description?.htmlToAttributedString
        })
        
    }
}
// MARK: - ...  Functions
extension TermsVC {
    func setup() {
        if isprivacy {
            viewModel?.getprivacy()
            titleLbl.text = "Privacy policy".localized
        }else {
            viewModel?.getterms()

        }
    }
}
// MARK: - ...  View Contract
extension TermsVC {
}

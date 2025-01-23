//
//  TermsVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class TermsVC: BaseController {
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var termsLbl: UILabel!
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
        setup()
        bind()
                (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
        
        viewModel?.setting.listen(on: { [weak self] value in
            self?.reload()
        })
    }
}
// MARK: - ...  Functions
extension TermsVC {
    func setup() {
        if isprivacy {
            desLbl.text = "Review of Privacy".localized
            titleLbl.text = "Privacy".localized
        }
        startLoading()
        viewModel?.fetchsetting()
    }
    func reload(){
        stopLoading()
        if isprivacy {
            termsLbl.text = viewModel?.setting.value?.privacy_policy?.htmlToString ?? ""
        }else {
            termsLbl.text = viewModel?.setting.value?.terms_condition?.htmlToString ?? ""
        }

    }
}
// MARK: - ...  View Contract
extension TermsVC {
}

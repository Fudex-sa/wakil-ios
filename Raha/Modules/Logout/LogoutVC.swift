//
//  LogoutVC.swift
//  Raha
//
//  Created by ADAM on 06/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class LogoutVC: BaseController {
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var viewModel: LogoutViewModel?
    var coordinator: LogoutCoordinator?
}

// MARK: - ...  LifeCycle
extension LogoutVC {
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
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.logout.listen(on: { [weak self] value in
            self?.dismiss(animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                UD.user = nil
                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
            }
        })
        
    }
}
// MARK: - ...  Functions
extension LogoutVC {
    func setup() {
        logoutBtn.publisher.listen(on: { [weak self] in
            self?.viewModel?.fetchlogout()
            
        }).store(self)
        cancelBtn.publisher.listen(on: { [weak self] in
            self?.coordinator?.close()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension LogoutVC {
}

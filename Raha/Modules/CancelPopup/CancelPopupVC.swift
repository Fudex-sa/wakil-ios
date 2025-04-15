//
//  CancelPopupVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CancelPopupVC: BaseController {
    @IBOutlet weak var backClickBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var viewModel: CancelPopupViewModel?
    var coordinator: CancelPopupCoordinator?
    var orderId = 0
}

// MARK: - ...  LifeCycle
extension CancelPopupVC {
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
        viewModel?.canceldata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle(self?.viewModel?.canceldata.value?.message ?? "")
                .setBody("Cancellation policy will apply".localized)
                .setTheme(.success)
                .bulid()
            self?.dismiss(animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                Coordinator.instance.restart(storyboard: R.storyboard.homeStoryboard())
            }
        })
        
    }
}
// MARK: - ...  Functions
extension CancelPopupVC {
    func setup() {
        viewModel?.orderId.send(orderId)
        cancelBtn.publisher.listen(on: { [weak self] in
            self?.viewModel?.fetchcancel()
            
        }).store(self)
        backClickBtn.publisher.listen(on: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension CancelPopupVC {
}

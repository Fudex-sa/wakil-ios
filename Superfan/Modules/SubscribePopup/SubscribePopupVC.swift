//
//  SubscribePopupVC.swift
//  Superfan
//
//  Created by ADAM on 29/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SubscribePopupVC: BaseController {
    @IBOutlet weak var subscripeBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: SubscribePopupViewModel?
    var coordinator: SubscribePopupCoordinator?
}

// MARK: - ...  LifeCycle
extension SubscribePopupVC {
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
extension SubscribePopupVC {
    func setup() {
        changeColoe()
        subscripeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: {
                let view = UIApplication.topViewController() as? BaseController
                guard let scene = R.storyboard.subscriptionsStoryboard.subscriptionsVC() else { return }
                view?.push(scene)
            })
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: {
            })
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            subscripeBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension SubscribePopupVC {
}

//
//  LogoutVC.swift
//  Raha
//
//  Created by ADAM on 06/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol LogoutVCDelegate: AnyObject {
    func address()

}
// MARK: - ...  ViewController - Vars
class LogoutVC: BaseController {
    enum VerifyType {
        case logout
        case address
        case account
        case notification
    }
    var delegate: LogoutVCDelegate?
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var logoutHight: NSLayoutConstraint!
    @IBOutlet weak var logoutImg: UIImageView!
    @IBOutlet weak var logoutLbl: UIButton!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var titlrLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var viewModel: LogoutViewModel?
    var coordinator: LogoutCoordinator?
    var type: VerifyType = .logout
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
                UD.address = nil
                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
            }
        })
        
    }
}
// MARK: - ...  Functions
extension LogoutVC {
    func setup() {
        if type == .address {
            logoutImg.isHidden = true
            logoutHight.constant = 0
            imgTop.constant = 0
            titlrLbl.text = "Delete address".localized
            bodyLbl.text = "Are you sure to delete address?".localized
            logoutLbl.setTitle("Delete".localized, for: .normal)
        }else if type == .notification {
            logoutImg.isHidden = true
            logoutHight.constant = 0
            imgTop.constant = 0
            titlrLbl.text = "Delete notification".localized
            bodyLbl.text = "Are you sure to delete notification?".localized
            logoutLbl.setTitle("Delete".localized, for: .normal)
        }else if type == .account {
            logoutImg.image = UIImage(named: "fi_3128607")
            titlrLbl.text = "Delete Account".localized
            bodyLbl.text = "Are you sure to delete your account from the app?".localized
            logoutLbl.setTitle("Delete".localized, for: .normal)
        }
        logoutBtn.publisher.listen(on: { [weak self] in
            if self?.type == .address {
                self?.delegate?.address()
                self?.dismiss(animated: true, completion: nil)
                return
            }
            if self?.type == .notification {
                self?.delegate?.address()
                self?.dismiss(animated: true, completion: nil)
                return
            }
            if self?.type == .account {
                self?.viewModel?.deleteaccount()
                return
            }
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

//
//  DeleteaccountpopupVC.swift
//  Wndo
//
//  Created by Adam on 13/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
protocol deleteAccountPopupVCDelegate: AnyObject {
    func deleteAccount()
    func done()
    func deleteNotification(type: Int)
    func deleteItemCart()
    func changepayment(type: Int)
}
extension deleteAccountPopupVCDelegate {
    func deleteAccount(){}
    func done(){}
    func deleteNotification(type: Int) {}
    func deleteItemCart(){}
    func changepayment(type: Int){}
}
class DeleteaccountpopupVC: BaseController {
    enum ViewType {
        case account
        case subscribe
        case comment
        case reply
        case post
        case resubscribe
    }
    @IBOutlet weak var discardBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    
    var viewType: ViewType = .account
    var reasonid = ""
    var viewModel: DeleteaccountpopupViewModel?
    var coordinator: DeleteaccountpopupCoordinator?
    var delegate: deleteAccountPopupVCDelegate?
    var type = 0
}

// MARK: - ...  LifeCycle
extension DeleteaccountpopupVC {
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
        viewModel?.delete.listen(on: { [weak self] value in
            self?.dismiss(animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                UD.user = nil
                UD.club = nil
                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
            }
        })
        
    }
}
// MARK: - ...  Functions
extension DeleteaccountpopupVC {
    func setup() {
        if UD.club != nil {
            doneBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
            discardBtn.borderColor = UIColor(hex: UD.club?.color ?? "")
            discardBtn.setTitleColor(UIColor(hex: UD.club?.color ?? ""), for: .normal)
        }
        if viewType == .comment {
            titleLbl.text = "Delete comment".localized
            desLbl.text = "Are you want to delete comment?".localized
        }else if viewType == .post {
            titleLbl.text = "Delete post".localized
            desLbl.text = "Are you want to delete post?".localized
        }else if viewType == .reply {
            titleLbl.text = "Delete reply".localized
            desLbl.text = "Are you want to delete reply?".localized
        }else if viewType == .subscribe {
            titleLbl.text = "Unsubscribe".localized
            desLbl.text = "Are you want to Unsubscribe?".localized
        }else if viewType == .resubscribe {
            titleLbl.text = "Unsubscribe".localized
            desLbl.text = "You are subscribed with this club in another package, if you subscribe to this package, another package will be deleted".localized
        }
        doneBtn.publisher.listen(on: { [weak self] in
            if self?.viewType == .account {
                self?.viewModel?.deleteaccount()
            }else {
                self?.dismiss(animated: true, completion: nil)
                self?.delegate?.done()
            }
            
        }).store(self)
        discardBtn.publisher.listen(on: { [weak self] in
            self?.coordinator?.close()
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension DeleteaccountpopupVC {
}

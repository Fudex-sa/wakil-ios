//
//  SlideMenuVC.swift
//  Superfan
//
//  Created by ADAM on 16/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SlideMenuVC: BaseController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var notSwitch: UISwitch!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var aboutusView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: SlideMenuViewModel?
    var coordinator: SlideMenuCoordinator?
}

// MARK: - ...  LifeCycle
extension SlideMenuVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        notSwitch.onTintColor = .green
        notSwitch.tintColor = .gray
        notSwitch.thumbTintColor = .white
        notSwitch.layer.cornerRadius = notSwitch.frame.height / 2
        notSwitch.backgroundColor = notSwitch.tintColor
        notSwitch.clipsToBounds = true

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
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.userddata.listen(on: { [weak self] value in
            self?.reload()
        })
        viewModel?.logout.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.closeMenu()
            UD.club = nil
            Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
        })
    }
}
// MARK: - ...  Functions
extension SlideMenuVC {
    func setup() {
        if UD.club != nil {
            containerView.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
        if UD.user == nil {
            logoutLbl.text = "Login".localized
            userView.isHidden = true
        }else {
            viewModel?.getprofile()
        }
        notSwitch.addTarget(self, action: #selector(switchPressed), for: .touchUpInside)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.closeMenu()
        }).store(self)
        aboutusView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.aboutus()
        }).store(self)
        termsView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.terms()
        }).store(self)
        languageView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.language()
        }).store(self)
        contactView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.contactus()
        }).store(self)
        logoutView.publisherGesture.listen(on: {[weak self] _ in
            if UD.user == nil {
                Coordinator.instance.unAuthorized()
                self?.closeMenu()
                return
            }
            self?.startLoading()
            self?.viewModel?.makelogout()
        }).store(self)
        notSwitch.isOn = UD.notificationStatus ?? true
    }
    func closeMenu(){
        if let parentViewController = self.parent as? HomeVC {
            parentViewController.closeMenu()
        }
    }
    func reload(){
        nameLbl.text = viewModel?.userddata.value?.data?.name ?? ""
        userImg.setImage(url: viewModel?.userddata.value?.data?.photo ?? "")
    }
    @objc func switchPressed() {
        if UD.notificationStatus == true {
            let application = UIApplication.shared
            application.unregisterForRemoteNotifications()
            UD.notificationStatus = false
        }else {
            let application = UIApplication.shared
            application.registerForRemoteNotifications()
            UD.notificationStatus = true
        }
    }
}
// MARK: - ...  View Contract
extension SlideMenuVC {
}

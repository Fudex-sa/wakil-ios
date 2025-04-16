//
//  MoreVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MoreVC: BaseController {
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var contactusView: UIView!
    @IBOutlet weak var complainView: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var profileView: UIView!
    var viewModel: MoreViewModel?
    var coordinator: MoreCoordinator?
}

// MARK: - ...  LifeCycle
extension MoreVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
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
            UD.user = nil
            Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
        })
    }
}
// MARK: - ...  Functions
extension MoreVC {
    func setup() {
        if UD.user == nil {
            profileView.isHidden = true
            logoutView.isHidden = true
        }else {
            viewModel?.getprofile()
        }
        profileView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.profile()
        }).store(self)
        aboutView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.aboutus()
        }).store(self)
        termsView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.terms()
        }).store(self)
        privacyView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.privacy()
        }).store(self)
        complainView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.complains()
        }).store(self)
        settingView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.setting()
        }).store(self)
        faqView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.faqs()
        }).store(self)
        contactusView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.contactus()
        }).store(self)
        logoutView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.logout()
        }).store(self)
    }
    func reload(){
        nameLbl.text = viewModel?.userddata.value?.data?.name ?? ""
        userImg.setImage(url: viewModel?.userddata.value?.data?.avatar ?? "")
    }
}
// MARK: - ...  View Contract
extension MoreVC {
}

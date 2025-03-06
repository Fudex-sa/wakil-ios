//
//  MoreCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class MoreCoordinator: Coordinator {
    typealias PresentingView = MoreVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MoreCoordinator {
    func profile() {
        guard let scene = R.storyboard.profileStoryboard.profileVC() else { return }
        view?.push(scene)
    }
    func setting() {
        guard let scene = R.storyboard.settingsStoryboard.settingsVC() else { return }
        view?.push(scene)
    }
    func aboutus() {
        guard let scene = R.storyboard.aboutusStoryboard.aboutusVC() else { return }
        view?.push(scene)
    }
    func terms() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        view?.push(scene)
    }
    func privacy() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        scene.isprivacy = true
        view?.push(scene)
    }
    func contactus() {
        guard let scene = R.storyboard.contactusStoryboard.contactusVC() else { return }
        view?.push(scene)
    }
    func faqs() {
        guard let scene = R.storyboard.faqStoryboard.faqVC() else { return }
        view?.push(scene)
    }
    func logout() {
        guard let scene = R.storyboard.logoutStoryboard.logoutVC() else { return }
        view?.pushPop(scene)
    }
}

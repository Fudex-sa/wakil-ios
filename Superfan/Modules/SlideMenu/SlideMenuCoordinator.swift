//
//  SlideMenuCoordinator.swift
//  Superfan
//
//  Created by ADAM on 16/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SlideMenuCoordinator: Coordinator {
    typealias PresentingView = SlideMenuVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SlideMenuCoordinator {
    func aboutus() {
        guard let scene = R.storyboard.aboutusStoryboard.aboutusVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func terms() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func language() {
        guard let scene = R.storyboard.changelanguageStoryboard.changelanguageVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func notification() {
        guard let scene = R.storyboard.notificationStoryboard.notificationVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func privacy() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        scene.isprivacy = true
        view?.push(scene)
        view?.closeMenu()
    }
    func rateapp() {
        Common().openUrl(text: "https://apps.apple.com/app/superfans/id6547850254")
        view?.closeMenu()
    }
    func contactus() {
        guard let scene = R.storyboard.contactusStoryboard.contactusVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func mypost() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            view?.closeMenu()
            return
        }
        guard let scene = R.storyboard.mypostsStoryboard.mypostsVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func subscribe() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            view?.closeMenu()
            return
        }
        guard let scene = R.storyboard.subscriptionsStoryboard.subscriptionsVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
}

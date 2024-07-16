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
        guard let scene = R.storyboard.aboutusStoryboard.aboutusVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func language() {
        guard let scene = R.storyboard.changelanguageStoryboard.changelanguageVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
    func contactus() {
        guard let scene = R.storyboard.contactusStoryboard.contactusVC() else { return }
        view?.push(scene)
        view?.closeMenu()
    }
}

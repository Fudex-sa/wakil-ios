//
//  Coordinator.swift
//  BaseIOS
//
//  Created by M.abdu on 10/12/20.
//  Copyright © 2020 com.. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Coordinator for All Application
class Coordinator: NSObject {
    let storyboard: UIStoryboard = R.storyboard.onboardingStoryboard()
    // MARK: - ...  Restart the main storyboard
    func restart(storyboard: UIStoryboard = Coordinator.instance.storyboard) {
        let scene = storyboard.instantiateInitialViewController()
        let delegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        delegate?.window?.rootViewController = scene
    }
    func unAuthorized() {
//        let scene = R.storyboard.auth.loginNav()
//        let delegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
//        delegate?.window?.rootViewController = scene
    }
    func networkFail() {
        let scene = UIApplication.topViewController() as? BaseController
        scene?.showNetworkFailScreen()
    }
    func maintance() {
        let scene = UIApplication.topViewController() as? BaseController
        scene?.showMaintanceScreen()
    }
    @objc dynamic func guest() {
//        guard let scene = R.storyboard.main.guestPopUpViewController() else { return }
//        let view = UIApplication.topViewController() as? BaseController
//        view?.pushPop(scene)
    }
}

// MARK: - ...  Coordinator Singletone
extension Coordinator {
    struct Static {
        static var instance: Coordinator?
    }
    class var instance: Coordinator {
        if Static.instance == nil {
            Static.instance = Coordinator()
        }
        return Static.instance!
    }
}

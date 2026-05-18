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
    let storyboard: UIStoryboard = R.storyboard.loginStoryboard()
    // MARK: - ...  Restart the main storyboard
    func restart(storyboard: UIStoryboard = Coordinator.instance.storyboard) {
        let scene = storyboard.instantiateInitialViewController()
        let delegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        delegate?.window?.rootViewController = scene
    }
    func unAuthorized() {
       // UD.address = nil
        let scene = R.storyboard.loginStoryboard().instantiateInitialViewController()
        let delegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        delegate?.window?.rootViewController = scene
    }
    func networkFail() {
        let scene = UIApplication.topViewController() as? BaseController
        scene?.showNetworkFailScreen()
    }
    func maintance() {
//        guard let scene = R.storyboard.forceUpdateStoryboard.forceUpdateVC() else { return }
//        let view = UIApplication.topViewController() as? BaseController
//       view?.push(scene)
    }
    @objc dynamic func suscribpopup() {
//        guard let scene = R.storyboard.subscribePopupStoryboard.subscribePopupVC() else { return }
//        let view = UIApplication.topViewController() as? BaseController
//        view?.pushPop(scene)
    }
    @objc dynamic func profileinit() {
//        guard let scene = R.storyboard.profileStoryboard.profileVC() else { return }
//        let view = UIApplication.topViewController() as? BaseController
//        view?.push(scene)
    }
    func forceupdate(msg: String) {
//        guard let scene = R.storyboard.forceUpdateStoryboard.forceUpdateVC() else { return }
//        let view = UIApplication.topViewController() as? BaseController
//        scene.msg = msg
//        view?.push(scene)
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

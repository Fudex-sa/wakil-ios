//
//  MainVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import FloatingTabBarController

// MARK: - ...  ViewController - Vars
class MainVC: UITabBarController {
}

// MARK: - ...  LifeCycle
extension MainVC {
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.tintColor = R.color.primary()
//        guard let homeVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeVC") as? UIViewController else {}
//        let notificationVC = NotificationVC()
//        let profileVC =  ProfileVC()
//                homeVC.title = "Home".localized
//        homeVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "hometab")!, normalImage:  UIImage(named: "hometab1")!)
//        profileVC.title = "Profile".localized
//        profileVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "usertab")!, normalImage:  UIImage(named: "usertab1")!)
//        notificationVC.title = "Notification".localized
//        notificationVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "notificationtab")!, normalImage:  UIImage(named: "notificationtab1")!)
//        viewControllers = [homeVC,profileVC,notificationVC]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
// MARK: - ...  Functions
extension MainVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension MainVC {
}

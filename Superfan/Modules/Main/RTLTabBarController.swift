//
//  RTLTabBarController.swift
//  Superfan
//
//  Created by ADAM on 14/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import FloatingTabBarController

class RTLTabBarController: FloatingTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = R.color.primary()
        configureViewControllers()
        adjustForRTL()
    }

    private func configureViewControllers() {
        guard let homeVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeVC") as? UIViewController else {
            return
        }
        let notificationVC = NotificationVC()
        let profileVC = ProfileVC()

        homeVC.title = "Home".localized
        homeVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "hometab")!, normalImage: UIImage(named: "hometab1")!)
        
        profileVC.title = "Profile".localized
        profileVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "usertab")!, normalImage: UIImage(named: "usertab1")!)
        
        notificationVC.title = "Notification".localized
        notificationVC.floatingTabItem = FloatingTabItem(selectedImage: UIImage(named: "notificationtab")!, normalImage: UIImage(named: "notificationtab1")!)
        
        viewControllers = [homeVC, profileVC, notificationVC]
    }

    private func adjustForRTL() {
        if Localizer.current == .arabic {
            tabBar.semanticContentAttribute = .forceRightToLeft
            tabBar.semanticContentAttribute = .forceRightToLeft
        }
    }
}

//
//  extensiond.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/6/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import UIKit
internal extension UIViewController {
    
    // View controller actively displayed in that layer. It may not be visible if it's presenting another view controller.
    var activeViewController: UIViewController {
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.topViewController?.activeViewController ?? self
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.activeViewController ?? self
        case let splitViewController as UISplitViewController:
            return splitViewController.viewControllers.last?.activeViewController ?? self
        default:
            return self
        }
    }
    
    // View controller being displayed on screen to the user.
    var topMostViewController: UIViewController {
        let activeViewController = self.activeViewController
        return activeViewController.presentedViewController?.topMostViewController ?? activeViewController
    }
    
    var containerViewController: UIViewController {
        return navigationController?.containerViewController ??
            tabBarController?.containerViewController ??
            splitViewController?.containerViewController ??
        self
    }
    
    @objc var isHidden: Bool {
        return presentingViewController == nil
    }
}

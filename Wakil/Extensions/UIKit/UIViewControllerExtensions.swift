//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit

// MARK: - Methods
public extension UIViewController {

	/// SwifterSwift: Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
    func setStatusBar(color: UIColor) {
            let tag = 12321
            if let taggedView = self.view.viewWithTag(tag){
                taggedView.removeFromSuperview()
            }
            let overView = UIView()
            overView.frame = UIApplication.shared.statusBarFrame
            overView.backgroundColor = color
            overView.tag = tag
            self.view.addSubview(overView)
        }

}

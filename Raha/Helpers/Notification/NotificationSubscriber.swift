//
//  NotificationSubscriber.swift
//  Ryde
//
//  Created by Mohamed Abdu on 24/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
enum NotificationType: String {
    case message, trip, offer, chat, approval, new_order, canceled_order, assigned_to_driver, assigned_to_you, provider_accepted_order, order , points, shared_cart_invitation
}

protocol NotificationSubscriber: NSObjectProtocol {
    func subscribe()
    func unsubscribe()
    // MARK: - ...  Did click on notification
    func notificationControl(json: Data)
    // MARK: - ...  Did present the notification
    func notificationControlWillPresent(notificationType: String?, json: String, closure: SoundHandler?)
}

extension NotificationSubscriber {
    func subscribe() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.notificationSubscriber = self
    }
    func unsubscribe() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.notificationSubscriber = nil
    }
    // MARK: - ...  Did click on notification
    func notificationControl(json: Data) { }
    // MARK: - ...  Did present the notification
    func notificationControlWillPresent(notificationType: NotificationType?, json: Data, closure: SoundHandler? = nil) { }
}

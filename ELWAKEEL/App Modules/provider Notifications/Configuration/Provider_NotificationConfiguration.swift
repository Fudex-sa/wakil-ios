//
//  Provider_NotificationConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class Provider_NotificationConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = Provider_NotificationViewController()
        let router = Provider_NotificationRouter(view: controller)
        let presenter = Provider_NotificationPresenter(view: controller)
        let worker = Provider_NotificationWorker()
        let interactor = Provider_NotificationInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

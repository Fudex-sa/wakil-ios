//
//  Clint_NotificationConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class Clint_NotificationConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = Clint_NotificationViewController()
        let router = Clint_NotificationRouter(view: controller)
        let presenter = Clint_NotificationPresenter(view: controller)
        let worker = Clint_NotificationWorker()
        let interactor = Clint_NotificationInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

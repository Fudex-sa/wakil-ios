//
//  sideMenuConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class sideMenuConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = sideMenuViewController()
        let router = sideMenuRouter(view: controller)
        let presenter = sideMenuPresenter(view: controller)
        let worker = sideMenuWorker()
        let interactor = sideMenuInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

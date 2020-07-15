//
//  creatingPasswordConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class creatingPasswordConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = creatingPasswordViewController()
        let router = creatingPasswordRouter(view: controller)
        let presenter = creatingPasswordPresenter(view: controller)
        let worker = creatingPasswordWorker()
        let interactor = creatingPasswordInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

//
//  LOGINConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class LOGINConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = LOGINViewController()
        let router = LOGINRouter(view: controller)
        let presenter = LOGINPresenter(view: controller)
        let worker = LOGINWorker()
        let interactor = LOGINInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

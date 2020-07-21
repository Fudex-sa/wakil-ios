//
//  LOGINRequesterConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class LOGINRequesterConfiguration {
    static func setup(parameters: [String: Any] = [:], userTypeL: String) -> UIViewController {
        let controller = LOGINRequesterViewController()
        let router = LOGINRequesterRouter(view: controller)
        let presenter = LOGINRequesterPresenter(view: controller)
        let worker = LOGINRequesterWorker()
        let interactor = LOGINRequesterInteractor(presenter: presenter, worker: worker)
        controller.type = userTypeL
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

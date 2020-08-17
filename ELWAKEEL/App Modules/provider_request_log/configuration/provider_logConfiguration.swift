//
//  provider_logConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class provider_logConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = provider_logViewController()
        let router = provider_logRouter(view: controller)
        let presenter = provider_logPresenter(view: controller)
        let worker = provider_logWorker()
        let interactor = provider_logInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

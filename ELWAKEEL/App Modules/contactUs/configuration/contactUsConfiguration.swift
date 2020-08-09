//
//  contactUsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class contactUsConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = contactUsViewController()
        let router = contactUsRouter(view: controller)
        let presenter = contactUsPresenter(view: controller)
        let worker = contactUsWorker()
        let interactor = contactUsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

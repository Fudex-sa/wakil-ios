//
//  addrequestConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class addrequestConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = addrequestViewController()
        let router = addrequestRouter(view: controller)
        let presenter = addrequestPresenter(view: controller)
        let worker = addrequestWorker()
        let interactor = addrequestInteractor(presenter: presenter, worker: worker)
        controller.provider_id = parameters["provider_id"] as? Int
        controller.advertizing_id = parameters["advertizing_id"] as? Int
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

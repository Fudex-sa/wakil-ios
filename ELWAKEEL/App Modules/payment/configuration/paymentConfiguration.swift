//
//  paymentConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class paymentConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = paymentViewController()
        let router = paymentRouter(view: controller)
        let presenter = paymentPresenter(view: controller)
        let worker = paymentWorker()
        let interactor = paymentInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        controller.request_id = parameters["request_id"] as? Int
        controller.offer_id = parameters["offer_id"] as? Int
        return controller
    }
}

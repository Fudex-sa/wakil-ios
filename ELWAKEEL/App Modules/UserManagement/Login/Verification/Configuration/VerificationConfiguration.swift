//
//  VerificationConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class VerificationConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = VerificationViewController()
        let router = VerificationRouter(view: controller)
        let presenter = VerificationPresenter(view: controller)
        let worker = VerificationWorker()
        let interactor = VerificationInteractor(presenter: presenter, worker: worker)
        controller.param = parameters
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

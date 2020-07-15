//
//  ForgetpasswordConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class ForgetpasswordConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = ForgetpasswordViewController()
        let router = ForgetpasswordRouter(view: controller)
        let presenter = ForgetpasswordPresenter(view: controller)
        let worker = ForgetpasswordWorker()
        let interactor = ForgetpasswordInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

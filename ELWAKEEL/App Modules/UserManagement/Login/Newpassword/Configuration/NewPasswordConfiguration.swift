//
//  NewPasswordConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class NewPasswordConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = NewPasswordViewController()
        let router = NewPasswordRouter(view: controller)
        let presenter = NewPasswordPresenter(view: controller)
        let worker = NewPasswordWorker()
        let interactor = NewPasswordInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

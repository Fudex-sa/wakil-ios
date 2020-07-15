//
//  registraionTypeConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class registraionTypeConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = registraionTypeViewController()
        let router = registraionTypeRouter(view: controller)
        let presenter = registraionTypePresenter(view: controller)
        let worker = registraionTypeWorker()
        let interactor = registraionTypeInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

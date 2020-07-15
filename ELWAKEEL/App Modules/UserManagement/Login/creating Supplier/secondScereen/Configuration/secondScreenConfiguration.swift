//
//  secondScreenConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class secondScreenConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = secondScreenViewController()
        let router = secondScreenRouter(view: controller)
        let presenter = secondScreenPresenter(view: controller)
        let worker = secondScreenWorker()
        let interactor = secondScreenInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

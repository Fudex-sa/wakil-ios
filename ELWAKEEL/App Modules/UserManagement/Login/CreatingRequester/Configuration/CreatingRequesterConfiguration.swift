//
//  CreatingRequesterConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class CreatingRequesterConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = CreatingRequesterViewController()
        let router = CreatingRequesterRouter(view: controller)
        let presenter = CreatingRequesterPresenter(view: controller)
        let worker = CreatingRequesterWorker()
        let interactor = CreatingRequesterInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

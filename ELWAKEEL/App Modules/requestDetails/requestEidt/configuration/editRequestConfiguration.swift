//
//  editRequestConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class editRequestConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = editRequestViewController()
        let router = editRequestRouter(view: controller)
        let presenter = editRequestPresenter(view: controller)
        let worker = editRequestWorker()
        let interactor = editRequestInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

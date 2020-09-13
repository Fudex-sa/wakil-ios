//
//  edit_profileConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class edit_profileConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = edit_profileViewController()
        let router = edit_profileRouter(view: controller)
        let presenter = edit_profilePresenter(view: controller)
        let worker = edit_profileWorker()
        let interactor = edit_profileInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

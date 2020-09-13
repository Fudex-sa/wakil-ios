//
//  change_passwordConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class change_passwordConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = change_passwordViewController()
        let router = change_passwordRouter(view: controller)
        let presenter = change_passwordPresenter(view: controller)
        let worker = change_passwordWorker()
        let interactor = change_passwordInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

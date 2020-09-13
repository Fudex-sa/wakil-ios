//
//  change_phoneConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class change_phoneConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = change_phoneViewController()
        let router = change_phoneRouter(view: controller)
        let presenter = change_phonePresenter(view: controller)
        let worker = change_phoneWorker()
        let interactor = change_phoneInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

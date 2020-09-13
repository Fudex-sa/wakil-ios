//
//  change_nameConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class change_nameConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = change_nameViewController()
        let router = change_nameRouter(view: controller)
        let presenter = change_namePresenter(view: controller)
        let worker = change_nameWorker()
        let interactor = change_nameInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

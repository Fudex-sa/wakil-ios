//
//  aboutUsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class aboutUsConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = aboutUsViewController()
        let router = aboutUsRouter(view: controller)
        let presenter = aboutUsPresenter(view: controller)
        let worker = aboutUsWorker()
        let interactor = aboutUsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

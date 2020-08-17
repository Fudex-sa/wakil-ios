//
//  editConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class editConfiguration {
    static func setup(parameters: [String: Any] = [:], id: Int) -> UIViewController {
        let controller = editViewController()
        let router = editRouter(view: controller)
        let presenter = editPresenter(view: controller)
        let worker = editWorker()
        let interactor = editInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        controller.id = id
        return controller
    }
}

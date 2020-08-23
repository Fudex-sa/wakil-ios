//
//  request_detailsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class request_detailsConfiguration {
    static func setup(parameters: [String: Any] = [:], request_id: Int) -> UIViewController {
        let controller = request_detailsViewController()
        let router = request_detailsRouter(view: controller)
        let presenter = request_detailsPresenter(view: controller)
        let worker = request_detailsWorker()
        let interactor = request_detailsInteractor(presenter: presenter, worker: worker)
        
        controller.request_id = request_id
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

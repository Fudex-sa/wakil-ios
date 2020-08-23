//
//  requestDetailsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class requestDetailsConfiguration {
    static func setup(parameters: [String: Any] = [:], id: Int, statu: String?) -> UIViewController {
        let controller = requestDetailsViewController()
        let router = requestDetailsRouter(view: controller)
        let presenter = requestDetailsPresenter(view: controller)
        let worker = requestDetailsWorker()
        let interactor = requestDetailsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        controller.id = id
        controller.statu = statu
        return controller
    }
}

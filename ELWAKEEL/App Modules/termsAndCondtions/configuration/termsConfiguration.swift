//
//  termsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class termsConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = termsViewController()
        let router = termsRouter(view: controller)
        let presenter = termsPresenter(view: controller)
        let worker = termsWorker()
        let interactor = termsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

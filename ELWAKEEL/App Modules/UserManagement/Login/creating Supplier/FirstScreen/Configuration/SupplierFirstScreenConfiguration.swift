//
//  SupplierFirstScreenConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class SupplierFirstScreenConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = SupplierFirstScreenViewController()
        let router = SupplierFirstScreenRouter(view: controller)
        let presenter = SupplierFirstScreenPresenter(view: controller)
        let worker = SupplierFirstScreenWorker()
        let interactor = SupplierFirstScreenInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

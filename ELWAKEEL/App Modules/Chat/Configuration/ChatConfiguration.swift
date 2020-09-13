//
//  ChatConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class ChatConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = ChatViewController()
        let router = ChatRouter(view: controller)
        let presenter = ChatPresenter(view: controller)
        let worker = ChatWorker()
        let interactor = ChatInteractor(presenter: presenter, worker: worker)
        controller.params = parameters
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

//
//  commonQuestionsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class commonQuestionsConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = commonQuestionsViewController()
        let router = commonQuestionsRouter(view: controller)
        let presenter = commonQuestionsPresenter(view: controller)
        let worker = commonQuestionsWorker()
        let interactor = commonQuestionsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}

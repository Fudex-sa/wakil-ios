//
//  secondScreenRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsecondScreenRouter: class {
	// do someting...
    func MoveToHome()
}

class secondScreenRouter: IsecondScreenRouter {
    func MoveToHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
	weak var view: secondScreenViewController?
	
	init(view: secondScreenViewController?) {
		self.view = view
	}
}

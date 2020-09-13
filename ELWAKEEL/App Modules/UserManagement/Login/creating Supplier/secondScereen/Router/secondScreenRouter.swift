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
    func MoveToVerification(type: String)

    
}

class secondScreenRouter: IsecondScreenRouter {
    func MoveToVerification(type: String) {
        view?.navigate(type: .push, module: GeneralRouterRoute.verification(params: ["type": type]), completion: nil)
    }
    
  
    
	weak var view: secondScreenViewController?
	
	init(view: secondScreenViewController?) {
		self.view = view
	}
}

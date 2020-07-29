//
//  LOGINRequesterRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRequesterRouter: class {
	// do someting...
    
    func navigateToHome()
}

class LOGINRequesterRouter: ILOGINRequesterRouter {
   
    
	weak var view: LOGINRequesterViewController?
	
	init(view: LOGINRequesterViewController?) {
		self.view = view
	}
    
    func navigateToHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
}

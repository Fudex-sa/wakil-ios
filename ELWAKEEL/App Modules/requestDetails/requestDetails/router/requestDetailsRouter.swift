//
//  requestDetailsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestDetailsRouter: class {
	// do someting...
    func goHome()
   

}

class requestDetailsRouter: IrequestDetailsRouter {
  
    
	weak var view: requestDetailsViewController?
	
	init(view: requestDetailsViewController?) {
		self.view = view
	}
    
    func goHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
}

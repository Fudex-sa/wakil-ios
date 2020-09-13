//
//  editRequestRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestRouter: class {
    func goHome()
    func edit_request(request_id: Int)
	// do someting...
}

class editRequestRouter: IeditRequestRouter {
    func edit_request(request_id: Int) {
        
         view?.navigate(type: .push, module: GeneralRouterRoute.edit(id: request_id), completion: nil)
    }
    
  
    
    func goHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
	weak var view: editRequestViewController?
	
	init(view: editRequestViewController?) {
		self.view = view
	}
}

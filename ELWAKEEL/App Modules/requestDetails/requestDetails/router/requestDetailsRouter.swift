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
    func go_chat(params: [String:Any])
   

}

class requestDetailsRouter: IrequestDetailsRouter {
    func go_chat(params: [String : Any]) {
        view?.navigate(type: .push, module: GeneralRouterRoute.chat(params: params), completion: nil)
    }
    
  
    
	weak var view: requestDetailsViewController?
	
	init(view: requestDetailsViewController?) {
		self.view = view
	}
    
    func goHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
}

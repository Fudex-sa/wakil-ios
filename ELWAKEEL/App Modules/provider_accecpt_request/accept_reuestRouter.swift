//
//  accept_reuestRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iaccept_reuestRouter: class {
	// do someting...
    func go_request_details(params: [String: Any])
    func go_home()
}

class accept_reuestRouter: Iaccept_reuestRouter {
    func go_home() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.HomeProvider, completion: nil)
    }
    
    func go_request_details(params: [String : Any]) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.request_details_provider(request_id: 30), completion: nil)    }
    
    
    
	weak var view: accept_reuestViewController?
	
	init(view: accept_reuestViewController?) {
		self.view = view
	}
}

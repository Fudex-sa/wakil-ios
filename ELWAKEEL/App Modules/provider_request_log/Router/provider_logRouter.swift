//
//  provider_logRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iprovider_logRouter: class {
    func request_details(request_id: Int)
	// do someting...
}

class provider_logRouter: Iprovider_logRouter {
    func request_details(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.details(request_id: request_id), completion: nil)
    }
    
    
	weak var view: provider_logViewController?
	
	init(view: provider_logViewController?) {
		self.view = view
	}
}

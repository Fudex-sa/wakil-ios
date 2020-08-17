//
//  paymentRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IpaymentRouter: class {
	// do someting...
    
    func go_request_details(request_id: Int)
    
}

class paymentRouter: IpaymentRouter {
    func go_request_details(request_id: Int) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.requestDetails(id: request_id), completion: nil)
    }
    
   
	weak var view: paymentViewController?
	init(view: paymentViewController?) {
		self.view = view
	}
}

//
//  Accept_RequestRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IAccept_RequestRouter: class {
	// do someting...
    func go_payment(params: [String: Any])
}

class Accept_RequestRouter: IAccept_RequestRouter {
    func go_payment(params: [String : Any]) {
    view?.navigate(type: .modal, module: GeneralRouterRoute.payment(params: params), completion: nil)
    }
    
	weak var view: Accept_RequestViewController?
	
	init(view: Accept_RequestViewController?) {
		self.view = view
	}
}

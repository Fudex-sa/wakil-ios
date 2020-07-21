//
//  ForgetpasswordRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IForgetpasswordRouter: class {
	// do someting...
    func goVerification(params: [String:Any])
    
}

class ForgetpasswordRouter: IForgetpasswordRouter {
    func goVerification(params: [String : Any]) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.verification(params: params), completion: nil)
    }
    
    
	weak var view: ForgetpasswordViewController?
	
	init(view: ForgetpasswordViewController?) {
		self.view = view
	}
}

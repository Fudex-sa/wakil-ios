//
//  VerificationRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IVerificationRouter: class {
    func goNewPassword(type: String, id: Int)
    func createNewPassword(phone: String)
	// do someting...
}

class VerificationRouter: IVerificationRouter {
    func createNewPassword(phone: String) {
view?.navigate(type: .modal, module: GeneralRouterRoute.newPassword(phone: phone), completion: nil)
        
    }
    
    
    
    func goNewPassword(type: String, id: Int) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.creatingPassword(type: type, id: id), completion: nil)
    }
    
	weak var view: VerificationViewController?
	
	init(view: VerificationViewController?) {
		self.view = view
	}
}

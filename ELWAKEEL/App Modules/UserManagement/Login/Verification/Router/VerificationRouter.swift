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
    func goNewpassword(phone: String)
    func createpassword(type: String, id: Int)
    func goHome()
	// do someting...
}

class VerificationRouter: IVerificationRouter {
    func createpassword(type: String, id: Int) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.creatingPassword(type: type, id: id), completion: nil)
    }
    
    func goHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
    func goNewpassword(phone: String) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.newPassword(phone: phone), completion: nil)
    }
    
    func createNewPassword(phone: String) {
view?.navigate(type: .modal, module: GeneralRouterRoute.newPassword(phone: phone), completion: nil)
        
    }
   
    
	weak var view: VerificationViewController?
	
	init(view: VerificationViewController?) {
		self.view = view
	}
}

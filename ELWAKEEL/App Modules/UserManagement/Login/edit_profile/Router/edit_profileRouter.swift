//
//  edit_profileRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iedit_profileRouter: class {
	// do someting...
    func change_name()
    func change_address()
    func change_phone()
    func change_city()
   func change_password()
}

class edit_profileRouter: Iedit_profileRouter {
    func change_city() {
         view?.navigate(type: .push, module: GeneralRouterRoute.change_city, completion: nil)
    }
    
    func change_password() {
         view?.navigate(type: .push, module: GeneralRouterRoute.change_password, completion: nil)
    }
    
    func change_name() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.change_name, completion: nil)
    }
    
    func change_address() {
         view?.navigate(type: .push, module: GeneralRouterRoute.change_address, completion: nil)
    }
    
    func change_phone() {
         view?.navigate(type: .push, module: GeneralRouterRoute.change_phone, completion: nil)
    }
    
	weak var view: edit_profileViewController?
	
	init(view: edit_profileViewController?) {
		self.view = view
	}
}

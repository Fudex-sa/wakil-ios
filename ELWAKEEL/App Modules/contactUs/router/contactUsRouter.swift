//
//  contactUsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsRouter: class {
    func backHome()
	// do someting...
    func show_side_menu()
}

class contactUsRouter: IcontactUsRouter {
    func show_side_menu() {
        if UserDefaults.standard.string(forKey: "type")  == "provider"
        {
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
            
        }
        else{
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
        }
    }
    
    func backHome() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
	weak var view: contactUsViewController?
	
	init(view: contactUsViewController?) {
		self.view = view
	}
}

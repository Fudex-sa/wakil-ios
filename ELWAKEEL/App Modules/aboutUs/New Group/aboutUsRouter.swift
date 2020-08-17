//
//  aboutUsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaboutUsRouter: class {
	// do someting...
    func show_side_menu()
}

class aboutUsRouter: IaboutUsRouter {
    func show_side_menu() {
        if UserDefaults.standard.string(forKey: "type")  == "provider"
        {
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
            
        }
        else{
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
        }
    }
    
	weak var view: aboutUsViewController?
	
	init(view: aboutUsViewController?) {
		self.view = view
	}
}

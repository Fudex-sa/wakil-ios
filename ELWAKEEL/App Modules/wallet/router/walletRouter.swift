//
//  walletRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IwalletRouter: class {
	// do someting...
    func show_side_menu()
}

class walletRouter: IwalletRouter {
    func show_side_menu() {
       
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
            
       
        
    }
    
	weak var view: walletViewController?
	
	init(view: walletViewController?) {
		self.view = view
	}
}

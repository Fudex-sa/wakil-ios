//
//  requestrecordRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestrecordRouter: class {
	// do someting...
     func request_details(request_id: Int)
    func show_side_menu()
}

class requestrecordRouter: IrequestrecordRouter {
    
    func request_details(request_id: Int) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.details(request_id: request_id), completion: nil)
    }
    func show_side_menu() {
      if UserDefaults.standard.string(forKey: "type")  == "provider"
        {
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
            
        }
        else{
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
        }
        
            }
    
	weak var view: requestrecordViewController?

	init(view: requestrecordViewController?) {
		self.view = view
	}
}

//
//  HomeProviderRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderRouter: class {
    func notifications()
    func accept_reuest(request_id: Int)
    func go_side_menu()
    func go_request_detail_provider(request_id: Int)
    func go_request_details(request_id: Int)
	// do someting...
}

class HomeProviderRouter: IHomeProviderRouter {
    func go_request_details(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.details(request_id: request_id), completion: nil)
    }
    
    func go_request_detail_provider(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.request_details_provider(request_id: request_id), completion: nil)
    }
    
    func go_side_menu() {
        view?.navigate(type: .push, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
       
    }
    
    func accept_reuest(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.accecpt_provider(request_id: request_id), completion: nil)
    }
    
    func notifications() {
        view?.navigate(type: .push, module: GeneralRouterRoute.client_notifications, completion: nil)
    }
    
	weak var view: HomeProviderViewController?
	
	init(view: HomeProviderViewController?) {
		self.view = view
	}
}

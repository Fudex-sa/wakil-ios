//
//  HomeRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeRouter: class {
	// do someting...
    
    func addRequest()
    func notifications()
    func go_offer(request_id: Int)
    func show_side_menu()
    func go_special_request(params:[String:Any])
}

class HomeRouter: IHomeRouter {
    func go_special_request(params: [String : Any]) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.addrequest(params: params), completion: nil)
    }
    
    func show_side_menu() {
    view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
    }
    
    func go_offer(request_id: Int) {
        view?.navigate(type: .modal, module: GeneralRouterRoute.offer(request_id: request_id), completion: nil)
    }
    
    func addRequest() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.addrequest(params: nil), completion: nil)
    }
    
    func notifications() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.client_notifications, completion: nil)
    }
    
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
}

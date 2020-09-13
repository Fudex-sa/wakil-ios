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
//    func show_side_menu()
    func go_special_request(params:[String:Any])
    func edit_request(request_id: Int)
    func request_details(request_id: Int, status: String)
    func details(request_id: Int)
}

class HomeRouter: IHomeRouter {
    func request_details(request_id: Int, status: String) {
        view?.navigate(type: .push, module: GeneralRouterRoute.requestDetails(id: request_id, statu: status), completion: nil)
    }
    
    func details(request_id: Int) {
         view?.navigate(type: .push, module: GeneralRouterRoute.details(request_id: request_id), completion: nil)
    }
    
    func edit_request(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.editRequest(id: request_id), completion: nil)
    }
    
    func go_special_request(params: [String : Any]) {
        view?.navigate(type: .push, module: GeneralRouterRoute.addrequest(params: params), completion: nil)
    }
    
    
    
    func go_offer(request_id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.offer(request_id: request_id), completion: nil)
    }
    
    func addRequest() {
        view?.navigate(type: .push, module: GeneralRouterRoute.addrequest(params: nil), completion: nil)
    }
    
    func notifications() {
        view?.navigate(type: .push, module: GeneralRouterRoute.client_notifications, completion: nil)
    }
    
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
}

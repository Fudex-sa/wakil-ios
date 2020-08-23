//
//  request_detailsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Irequest_detailsPresenter: class {
	// do someting...
    func assign_request(request: request_detailsModel.provider_Request_Details?)
    func cancel()
    func done_request()
    func evaluate_client()
}

class request_detailsPresenter: Irequest_detailsPresenter {
    func evaluate_client() {
        view?.evaluate_clinet()
    }
    
    func done_request() {
        view?.go_home()
    }
    
    func cancel() {
        view?.cancle()
    }
    func assign_request(request: request_detailsModel.provider_Request_Details?) {
            view?.assign_request_details(request: request)
    }
    
	weak var view: Irequest_detailsViewController?
	
	init(view: Irequest_detailsViewController?) {
		self.view = view
	}
}

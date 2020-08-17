//
//  HomeProviderPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderPresenter: class {
	// do someting...
    func assign_near_requests(requests: HomeProviderModel.new_requests)
    func assign_provider_requests(requests: HomeProviderModel.provider_request)
    func reject_request()
}

class HomeProviderPresenter: IHomeProviderPresenter {
    func reject_request() {
        view?.reject_request_done()
    }
    
    func assign_provider_requests(requests: HomeProviderModel.provider_request) {
        view?.assign_provider_requests(request: requests)
    }
    
    func assign_near_requests(requests: HomeProviderModel.new_requests) {
        view?.assign_requests(requests: requests)
    }
    
	weak var view: IHomeProviderViewController?
	
	init(view: IHomeProviderViewController?) {
		self.view = view
	}
}

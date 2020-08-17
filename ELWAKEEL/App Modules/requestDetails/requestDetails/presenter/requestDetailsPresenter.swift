//
//  requestDetailsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestDetailsPresenter: class {
	// do someting...
    func cancel()
    func assign_request(request: requestDetailsModel.RequestDetails?)

}

class requestDetailsPresenter: IrequestDetailsPresenter {
    func assign_request(request: requestDetailsModel.RequestDetails?) {
    view?.assign_request_details(request: request)
    }
    
	weak var view: IrequestDetailsViewController?
	
	init(view: IrequestDetailsViewController?) {
		self.view = view
	}
    
    func cancel() {
        view?.cancle()
    }
    
}

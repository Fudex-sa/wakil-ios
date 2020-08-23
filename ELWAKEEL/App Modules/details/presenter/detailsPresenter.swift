//
//  detailsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IdetailsPresenter: class {
    func assign_request(request: detailsModel.Request_Details?)

	// do someting...
}

class detailsPresenter: IdetailsPresenter {
    func assign_request(request: detailsModel.Request_Details?) {
        view?.assign_request_details(request: request)

    }
    
	weak var view: IdetailsViewController?
	
	init(view: IdetailsViewController?) {
		self.view = view
	}
}

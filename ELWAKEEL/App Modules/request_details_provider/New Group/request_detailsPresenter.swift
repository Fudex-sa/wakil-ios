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
}

class request_detailsPresenter: Irequest_detailsPresenter {	
	weak var view: Irequest_detailsViewController?
	
	init(view: Irequest_detailsViewController?) {
		self.view = view
	}
}

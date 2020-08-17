//
//  request_detailsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Irequest_detailsRouter: class {
	// do someting...
}

class request_detailsRouter: Irequest_detailsRouter {	
	weak var view: request_detailsViewController?
	
	init(view: request_detailsViewController?) {
		self.view = view
	}
}

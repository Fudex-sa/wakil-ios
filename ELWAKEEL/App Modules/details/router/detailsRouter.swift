//
//  detailsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IdetailsRouter: class {
	// do someting...
}

class detailsRouter: IdetailsRouter {	
	weak var view: detailsViewController?
	
	init(view: detailsViewController?) {
		self.view = view
	}
}

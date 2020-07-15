//
//  creatingPasswordRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcreatingPasswordRouter: class {
	// do someting...
}

class creatingPasswordRouter: IcreatingPasswordRouter {	
	weak var view: creatingPasswordViewController?
	
	init(view: creatingPasswordViewController?) {
		self.view = view
	}
}

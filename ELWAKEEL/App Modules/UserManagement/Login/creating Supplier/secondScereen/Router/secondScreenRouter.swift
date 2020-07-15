//
//  secondScreenRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsecondScreenRouter: class {
	// do someting...
}

class secondScreenRouter: IsecondScreenRouter {	
	weak var view: secondScreenViewController?
	
	init(view: secondScreenViewController?) {
		self.view = view
	}
}

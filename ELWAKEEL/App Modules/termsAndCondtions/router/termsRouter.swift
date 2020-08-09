//
//  termsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ItermsRouter: class {
	// do someting...
}

class termsRouter: ItermsRouter {	
	weak var view: termsViewController?
	
	init(view: termsViewController?) {
		self.view = view
	}
}

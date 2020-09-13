//
//  change_cityRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_cityRouter: class {
	// do someting...
}

class change_cityRouter: Ichange_cityRouter {	
	weak var view: change_cityViewController?
	
	init(view: change_cityViewController?) {
		self.view = view
	}
}

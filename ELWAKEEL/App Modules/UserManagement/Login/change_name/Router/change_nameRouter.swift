//
//  change_nameRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_nameRouter: class {
	// do someting...
}

class change_nameRouter: Ichange_nameRouter {	
	weak var view: change_nameViewController?
	
	init(view: change_nameViewController?) {
		self.view = view
	}
}

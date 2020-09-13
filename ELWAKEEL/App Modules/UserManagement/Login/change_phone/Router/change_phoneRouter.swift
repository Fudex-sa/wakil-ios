//
//  change_phoneRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_phoneRouter: class {
	// do someting...
}

class change_phoneRouter: Ichange_phoneRouter {	
	weak var view: change_phoneViewController?
	
	init(view: change_phoneViewController?) {
		self.view = view
	}
}

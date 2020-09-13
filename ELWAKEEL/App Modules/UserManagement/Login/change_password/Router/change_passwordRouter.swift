//
//  change_passwordRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_passwordRouter: class {
	// do someting...
}

class change_passwordRouter: Ichange_passwordRouter {	
	weak var view: change_passwordViewController?
	
	init(view: change_passwordViewController?) {
		self.view = view
	}
}

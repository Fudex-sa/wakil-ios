//
//  change_addressRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_addressRouter: class {
	// do someting...
}

class change_addressRouter: Ichange_addressRouter {	
	weak var view: change_addressViewController?
	
	init(view: change_addressViewController?) {
		self.view = view
	}
}

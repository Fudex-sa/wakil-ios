//
//  contactUsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsRouter: class {
	// do someting...
}

class contactUsRouter: IcontactUsRouter {	
	weak var view: contactUsViewController?
	
	init(view: contactUsViewController?) {
		self.view = view
	}
}

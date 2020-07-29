//
//  editRequestRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestRouter: class {
	// do someting...
}

class editRequestRouter: IeditRequestRouter {	
	weak var view: editRequestViewController?
	
	init(view: editRequestViewController?) {
		self.view = view
	}
}

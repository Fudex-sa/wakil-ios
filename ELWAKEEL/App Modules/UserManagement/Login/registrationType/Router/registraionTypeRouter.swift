//
//  registraionTypeRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IregistraionTypeRouter: class {
	// do someting...
}

class registraionTypeRouter: IregistraionTypeRouter {	
	weak var view: registraionTypeViewController?
	
	init(view: registraionTypeViewController?) {
		self.view = view
	}
}

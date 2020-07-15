//
//  SupplierFirstScreenRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISupplierFirstScreenRouter: class {
	// do someting...
}

class SupplierFirstScreenRouter: ISupplierFirstScreenRouter {	
	weak var view: SupplierFirstScreenViewController?
	
	init(view: SupplierFirstScreenViewController?) {
		self.view = view
	}
}

//
//  SupplierFirstScreenPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISupplierFirstScreenPresenter: class {
	// do someting...
}

class SupplierFirstScreenPresenter: ISupplierFirstScreenPresenter {	
	weak var view: ISupplierFirstScreenViewController?
	
	init(view: ISupplierFirstScreenViewController?) {
		self.view = view
	}
}
